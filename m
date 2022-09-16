Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7895BB196
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIPR1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPR1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:27:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9118AE89
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:27:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so2101736pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UyWqRe5MVdeXCpVzDr2ABned/JszdfyREGM9jJ5sQrM=;
        b=ZR5nmoavwk+87rfzPPmsyfUvVkz76glpVzTHcbNP/gbz5LaNphzPaS1ucnPcqhlQGf
         Wcxt76Hgq3h/uiwiQg7C/2Jgs8ynqrqzLk33VzUBnyGdblJtS+icXJZMJc12ghzRk1tD
         n2wNOHHibFFQMaOUn/j2NXvfDR++XI8ruo1f6XYbujd0Lag0p3LjYKzhwse4AkixFMqP
         +EYk0ILyrpwdH6aYdca1QSQ6QD7u1x2sXV57cydgKVaKOEtd6FzBiJJSGUtfjUsRlMh+
         C+xV4ZtdHUt2JwapV7nY9jR2zg2PtsnIAOj4Hn+NjlzxOCW3Kn8hIFId7pOFOnl+RllX
         6biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UyWqRe5MVdeXCpVzDr2ABned/JszdfyREGM9jJ5sQrM=;
        b=xIN329q/TOe68Cm+LSZprwIvE2gYSAG1/PtEnxMPWsRYr1VzrLxSduc8BVjDa7x4mZ
         QRNDcsnIFl0ORyRn0BX/9WDTf4P6MhVyOT8SMXo9HTHNBLHsC6QQadD2kREgLJQEWEp/
         LZujenOmLgkaJ2VlBhUdYj3Rf1Zv8q6i4uPYiOj7T/AzCrq6sg+hiZgHGcYJTKA7vU0X
         fLsl8VKQ/z8d3ZlggRaZUjInonxLQD53GGKcAb8VHgKi9hjUDytQuFqWfoKqcUatS7zz
         U2Ba0UK4yBRgG5B7nz5YgahtwyTQckZ8dd2o/dBo1g+0NICAeiXcQskIAM61Qrj1lRZ+
         swOw==
X-Gm-Message-State: ACrzQf2XY/30M4JLqn5oqwXrkCJ5LSgLt5Pa1x8RI2SvJRQJgwB2oal/
        G3PAtIZX3jeRL1ux7Uset0z5fw==
X-Google-Smtp-Source: AMsMyM7FK0LXPA3SPb/96N6U1OwN6w17UHL/7MrTYQAL9sj9KQm1ME3k4S7AmREnC7XfL/KrECveuQ==
X-Received: by 2002:a17:902:b18e:b0:178:3484:f45e with SMTP id s14-20020a170902b18e00b001783484f45emr866965plr.166.1663349234923;
        Fri, 16 Sep 2022 10:27:14 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b0017682b90532sm15177810plg.194.2022.09.16.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 10:27:14 -0700 (PDT)
Date:   Fri, 16 Sep 2022 17:27:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     liujing <liujing@cmss.chinamobile.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: duplicate code
Message-ID: <YySx7mc3KihEChbI@google.com>
References: <20220916032656.6264-1-liujing@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916032656.6264-1-liujing@cmss.chinamobile.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"KVM: x86/mmu:" for the scope.

And explicitly state what the patch does, not what the symptom is, especially since
"duplicate" can be an adjective, noun, or a verb depending on context.  And as an
almost nit, state that it's a comment so that it's obvious from the shortlog that
the patch should have no functional impact.

On Thu, Sep 15, 2022, liujing wrote:
> in "static int FNAME(walk_addr_generic)" function,
> there is an explanation that uses two to's, which is redundant code

Again, explicitly state what the patch actually does.

All that said, a patch has already been submitted for this[*].  No need to send a
v2, I'll grab the previous patch.

Thanks!

[*] https://lore.kernel.org/all/20220831125217.12313-1-yuanjilin@cdjrlc.com
