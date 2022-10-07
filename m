Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401925F7DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJGTRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGTR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:17:28 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABF330F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:17:27 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id s1-20020a4a81c1000000b0047d5e28cdc0so4102982oog.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2JDsqVdZnjWlaOQvu6EPe39LCBHFKQkuG1fa3tT0Gjw=;
        b=FayXRpNYC52MB8bTFhSz9+bsYprGVX95RfpxGW5qmC9ETLZKKhPBNDgsrYpSrOLKac
         x7J7OjkHOv2jzukOS0U+18mOEFxY76SKT3qOv1XfdOyEu1dfIvmA6dYbGzNed9AzfWSv
         9kakobjTxkn4LVnsYDdRzVAdFCA2TQ04sYgYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JDsqVdZnjWlaOQvu6EPe39LCBHFKQkuG1fa3tT0Gjw=;
        b=o/ZAfSigccvlqWr/qAoqKat86Wg7tWJJQNyPSBerMxdlgq5eam1IvfgzrnFwpEzNNi
         TUpmL+ry2J6fu5BF+qM/iaPS2OayXemsL5Mth3dqeXwchQvo4ptLe6v+CqwLdMMK4wTE
         nhRbwohkGAP1nIrq9MGpauksU3ZCwUAqgYBpT2PD5zuDgOa/wbL/iTICbBrzmd7S4Lp1
         DQr5lSrfhXCZTDeJQj7r6viVzJyaKOkUKaZybrm5eu5A7wImyjxxTZ/jatTxToKClMGw
         +1X3AVQY8WQFQ9Br1dpHOFAu3GCFEisE48uNiM6gctGkEFtm4C7rKeEFRCZcn9lOwBJ2
         3jZw==
X-Gm-Message-State: ACrzQf2AftNHfZWFFL2V6fgSYOQKxe0hklwWUxIXj9zuMb4fymXrgNLk
        f4jesCm25fXyo5xn66iUUuZBwIOc9Ai9Cg==
X-Google-Smtp-Source: AMsMyM7nvkkZeVShgs/JN9ElYnAZSxY98dG7fg8ZPFAZ1JboUwopQtl5rjVpXGI2r8KpUUI+TJdwig==
X-Received: by 2002:a05:6830:6101:b0:65b:d1b2:256e with SMTP id ca1-20020a056830610100b0065bd1b2256emr2816365otb.118.1665170246061;
        Fri, 07 Oct 2022 12:17:26 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id p204-20020aca42d5000000b003436fa2c23bsm1381646oia.7.2022.10.07.12.17.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 12:17:25 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13207a86076so6618211fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 12:17:25 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr3561496oab.229.1665170244926; Fri, 07
 Oct 2022 12:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <3727e267ba5a03e021ba06e46a97f260dcccc3e7.camel@HansenPartnership.com>
In-Reply-To: <3727e267ba5a03e021ba06e46a97f260dcccc3e7.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Oct 2022 12:17:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAUVVgVQWHig=rK1sw7RhjVENrqXDcKGF_mP8mmU9oFA@mail.gmail.com>
Message-ID: <CAHk-=whAUVVgVQWHig=rK1sw7RhjVENrqXDcKGF_mP8mmU9oFA@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.0+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 9:16 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> The patch is available here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

Nope. Nothing there. That's just very old state from July.

And since the pull request isn't even standard 'git request-pull'
format, there's no indication of what the top commit *should* be.

Please fix and re-post a proper pull request,

               Linus
