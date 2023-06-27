Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1613373F454
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjF0GPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjF0GPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:15:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CB51722
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:14:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fa96fd79f0so25360235e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687846497; x=1690438497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VHlKtlmPgyjqS986fc2zdJSD+esonOp/AIyWxyN5l1o=;
        b=WYYQz/bPplsPqU3DeZIeOnb2Xo81iaxLANnfTGKMQhaxh/f6hgP7BAmiMn+8VDd3Y+
         dejEPPrwyVSrDrVax13p7frJW508dsjA/+O8MUw85sczaCiTI8X5ortgaLG/oqwkLQKj
         Hna0jO7+UaBx/hi0OM4TexEdWcNIOLV/jhUul6AUg3TAHOi8HJ4JjCzaTJML/VLxcM1X
         NXZQgNsFBC1FybaOIpYIDXhxtd2unjCntcBFi9ECX49WWDU9vuujJIDgsJLoTuoS6myB
         34UuTm+le/jyZXbutLL9NnHEChb3LG9KdZdqm1kIKGDGaUHVZBf2sLvEzL1csz+VPgYO
         HZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687846497; x=1690438497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHlKtlmPgyjqS986fc2zdJSD+esonOp/AIyWxyN5l1o=;
        b=VECPlKwJ95/0HVcgvp1MKzIDsg4AP9zqFe5epLWC1VxP7iz1N6TsmJzJFqGoCoh50p
         KTvbUl4A4QjO/G0AV28Vyxhi14arFLE1DRNuwLwG2htblTD8Ojrsw4F1rz27WAqXpCk8
         K514/32jZ8bpc+G20eBbaa/XwNoy856x3u3ZchaZoOrdJNsV9FVc9ufgEPEwsw4KrVpf
         SfzbuLqNvCKxkeeLorARj/4Qy+RZJZWvi3zH4viAanx89kbNfHEYIvOA/mz4cg+90Bjj
         eMJgIocQTnh4Alv7/fpSa/53CZBn7ChhgQGGgqGg/EO0VfODtQ1eb7lMYeoX9PT20Cdy
         6V4Q==
X-Gm-Message-State: AC+VfDwjax0mEoahFcI4d1mFMH6atmNiCgBJ203q4Y9OAeaUwZaHszwy
        Rczf5jlULECe09br3D1fE1O41A==
X-Google-Smtp-Source: ACHHUZ4Hau+zrVHaLTx/1I0GQLyePIEGyq3qbz6eW2P9G1juJuspLRx2PdBqMY5bk1GdQksQMKdIyQ==
X-Received: by 2002:a05:600c:28e:b0:3fa:8aed:d57f with SMTP id 14-20020a05600c028e00b003fa8aedd57fmr7467202wmk.24.1687846497533;
        Mon, 26 Jun 2023 23:14:57 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l21-20020a1c7915000000b003f605566610sm12500939wme.13.2023.06.26.23.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 23:14:55 -0700 (PDT)
Date:   Tue, 27 Jun 2023 09:14:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        dm-devel@redhat.com, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v2 2/4] dm ioctl: Allow userspace to provide expected
 diskseq
Message-ID: <ab9f1618-5dde-4c70-a88e-c65f33abdb73@kadam.mountain>
References: <20230624230950.2272-3-demi@invisiblethingslab.com>
 <3241078c-2318-fe1b-33cc-7c33db71b1a6@web.de>
 <ZJh73z2CsgHEJ4iv@itl-email>
 <e42e8115-6f75-447e-9955-ca4ad43ed406@kadam.mountain>
 <1c1cd489-6d59-00ed-a1f5-497ca532c08d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c1cd489-6d59-00ed-a1f5-497ca532c08d@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 06:20:14PM +0200, Markus Elfring wrote:
> > …, stop bothering people about trivial nonsense. …
> 
> See also another bit of background information once more:
> [PATCH v2] certs/extract-cert: Fix checkpatch issues
> 2023-06-09
> https://lore.kernel.org/kernel-janitors/c464c4ee-038c-47bf-857a-b11a89680e82@kadam.mountain/
> https://lkml.org/lkml/2023/6/9/879

Markus, it's not about imperative tense.  It's about you wasting
people's time.

Read the subject again.  "Allow userspace to provide expected diskseq".
That is imperative tense.  I have not pointed it out to you because it
just doesn't matter at all.  If it's in imperative tense or if it's not
in imperative tense, it doesn't matter.

You're sending out a lot of messages and quite a few times it looks like
your targeting newbies.  One new developer sent me an email privately
who was over the top grateful when I told him he could ignore you.  The
guy was like, "I was so puzzled, because it's my first patch and I
didn't know how to respond."  This was an experienced programmer who we
want, but he was new to the kernel community so he didn't know if we had
bizarre rules or whatever.

I've looked through your patches that have recently been merged.  Some
of those maintainers know that you are banned and that your patches are
not getting any review from the mailing list.  We are really trying to
be nice and to work around your situation.  But don't start bothering
newbies who don't know what the situation is.

regards,
dan carpenter
