Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DDB609876
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJXDHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJXDHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:07:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03850748DA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 20:07:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so2278254pjc.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 20:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSG5pKXEMOX4Hxoh4vkf2ZzKyaQJNTqhWFdegxKWYNo=;
        b=gXThecH477Xe6h3lKH+zjHyVpBha0+4GyMD4kI2Ouw8rSEPKxO05R4ueRNAh9Q17bM
         JPfEsYoOgtz7/l2zEAamfJ09dx+FtiqtyTGB4hzkNcfc9tBWT3C/C5hgUsRqlJbKRjcs
         A7Ul7RP7+WIs+LzsqC4OXD1Soq+IDoaaZB2iYo9lhHlRzUfisZLJvuNouMlgcqXbnj0g
         RFo6PK8/RLv9RPcLAMCszCj0qsXteSkAszhbEvP5zO1FyT11vG6jg8Qcm53aG/u2n4ay
         u6Mq1pmMPSQMMJtAncbSBGZwRJlyi+XbgB92qYXsEY+F4FwIhW4iKUa2HkvaeuuvBwB4
         ssrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSG5pKXEMOX4Hxoh4vkf2ZzKyaQJNTqhWFdegxKWYNo=;
        b=7obniq8/SCaEd0UoUTTqVf00j2Ku0vsNiFi0omH2gLFtjOe9S9Vbe9URg1ZWu/uloG
         +VNsfA7Jdw+eXva+yp28z1qhwlScQgzG511apDP6ocgpNTJpP3ZRXCtcZpA47/S/xcRL
         eL5oFkJ26vGiRw+Vp2VnFf/3ijvzGeuTyi7Yi5mnhpOzz6f83yXY/xad3AY/EpAJxs3R
         kBN69Cjuy0whe5eOTGJZEPUsRRGJ4/doogU2iAUvC6CdE4rtOhxH8A5EcYl0OPKoVAkV
         QaB5VX345e0bJ8LZrCHdo32SeeYTOEtL4AVyvBM1UQrVSQuuHTr0l1V81wakX2mr71Kw
         6pRA==
X-Gm-Message-State: ACrzQf3GxtxZ5i6TBtxbBC2aLRRdtN6LVYoRY3YAIcleGgXIo3oWJ1JQ
        rBwliRAXElr1ZJLT424guY4=
X-Google-Smtp-Source: AMsMyM4dVcREkXLNr99Ky41B9mBxLqhlPGQZOH2pvVdhRZ7nHByihwF8u8N64NZjHec2KzKZ6BJ7OQ==
X-Received: by 2002:a17:903:1105:b0:178:ae31:aad with SMTP id n5-20020a170903110500b00178ae310aadmr31138447plh.3.1666580865525;
        Sun, 23 Oct 2022 20:07:45 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id oa11-20020a17090b1bcb00b001f262f6f717sm2146971pjb.3.2022.10.23.20.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 20:07:44 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re:[PATCH v3 0/5] ksm: support tracking KSM-placed zero-pages
Date:   Mon, 24 Oct 2022 03:07:41 +0000
Message-Id: <20221024030741.440709-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6eea25bf-08a8-641e-2360-68884e194608@redhat.com>
References: <6eea25bf-08a8-641e-2360-68884e194608@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>>>> A full description of the real-world end-user operational benefits of
>>>> these changes would help, please.
>>>>
>>>
>>> The core idea of this patch set is to enable users to perceive the number of any
>>> pages merged by KSM, regardless of whether use_zero_page switch has been turned
>>> on, so that users can know how much free memory increase is really due to their
>>> madvise(MERGEABLE) actions.
>> 
>> OK, thanks.
>> 
>>> The motivation for me to do this is that when I do
>>> an application optimization of KSM on embedded Linux for 5G platform, I find
>>> that ksm_merging_pages of some process becomes very small(but used to be large),
>>> which led me to think that there was any problem with the application KSM-madvise
>>> strategy, but in fact, it was only because use_zero_pages is on.
>> 
>> Please expand on the above motivation and experience, and include it in
>> the [0/n] changelog.  But let's leave it a few days to see if there's
>> additional reviewer input.
>> 
>
>I just posted a selftest:
>
>https://lore.kernel.org/all/20221021101141.84170-5-david@redhat.com/T/#u
>
>That could (should) be extended to test if unmerging works as expected.
>

Yes. As you said, these selftests can be extended to test if unsharing KSM-placed
zero pages works as expected, and I'm happy to do the extending after they are merged.

>
>Having that said, I think we really want a second pair of (KSM-expert) 
>eyes on these changes before moving forward with them.

OK, don't worry. Let it be reviewed for a more time, so as to absorb more views later.
If necessary, I will resend the patches to adjust to break_ksm()'s changes.
