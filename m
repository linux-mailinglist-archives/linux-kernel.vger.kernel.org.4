Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1398733567
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjFPQHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjFPQHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:07:40 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B192D5D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:07:39 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-760dff4b701so10227339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686931658; x=1689523658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBiz/Mt5xWYRFji0Ec1DEEBKtDnpmQmcZ7A3+2PxUAM=;
        b=fseNIKgGtGh/yQpHAf7O0q1/PqxDuAyDIjFrgrZHnQ2iu7jD8UZjnjtcHHG+GvMemZ
         C8u4Z6BfJ4oKB005waeqrzvWXol32cpK221xxlxLCJYz1Jfqk0e5zuK5s/vC1FxqHSkj
         UHQhmBXvy3K4ZZ3IXHZmCDJkgKT2J0Q+BOj4xK2wenDvuyqDDsZX3oxqG/2AYTs338u3
         DFF5IZP2oMNi3MBosSoZDCOp8AJqBKdc2LDBM2AJ2lXk7g2II29M6H74Vdm6Bm86fkRi
         OkY4D3uRVtkAt/fK51v7m9G21RygdwsPlBoXBAdG0DrYHthIycpKhMB16OHLkyNvzM/t
         yG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686931658; x=1689523658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBiz/Mt5xWYRFji0Ec1DEEBKtDnpmQmcZ7A3+2PxUAM=;
        b=OiGWBWlghkDpCLSkfj5Yca9EDKY3iRpipWTMG4YKBIHijN53oXcYYPze8DlD+Y8UtF
         adeb96f362KNGYiLdZqWS5F8VLtRD7Vr8eX+rtSRpLJZbOS0l/101NxzuAUH3GfJdbdH
         9q+pBMUPIFIN0/jq2gvF09+a8iVGg68isZFNm8SGim2mi08u+1zzyETH+utguvFzWysU
         w+z92Cy9opvNcRsHmchi5hD8o7UABHo4e9q62lvpMHTgJO4Sl/C5BCBTYBqmBs6eSwVO
         4k2olXDiWEiFP7WAtzw//yTVKbjHOczn3fbNowL/5TDSNteuJqfOveS8my2q5CVPn3vv
         QJZQ==
X-Gm-Message-State: AC+VfDxTA01Ljawkd/Rp+kX4Z/Mwhe/koencuBg3D8ch/5vf/3y2nq3o
        kV4esz9BRLTGgBsxedrW4r+dpg==
X-Google-Smtp-Source: ACHHUZ4ykMsGxl3b0JpxqzrQSJ0WPNS/m1X/Lg9u0n4XlXZ7r1WDBYg03nhOe2qA3mZ/h4hM5qI/VQ==
X-Received: by 2002:a6b:b744:0:b0:77e:23a7:c9eb with SMTP id h65-20020a6bb744000000b0077e23a7c9ebmr92463iof.0.1686931658573;
        Fri, 16 Jun 2023 09:07:38 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ed13-20020a056638290d00b004161870da90sm6387967jab.151.2023.06.16.09.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:07:37 -0700 (PDT)
Message-ID: <dded1115-c7e1-486f-2564-a5c6ea013bcd@kernel.dk>
Date:   Fri, 16 Jun 2023 10:07:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: manual merge of the block tree with the mm tree
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20230615205014.8d7eb4457ca9bc676a79d2db@linux-foundation.org>
 <20230616115856.3ce7682c@canb.auug.org.au>
 <424129.1686909362@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <424129.1686909362@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 3:56?AM, David Howells wrote:
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> That's getting a bit nasty.  Maybe David's patches are in the wrong
>> tree.
> 
> You'd need to discuss that one with Jens.  The patches you'd have to
> transfer also touch a number of block-related files.  Looking at
> block/for-next, there don't seem to be many other patches touching
> those files, but I've seen patches from Christoph that will need to be
> applied on top of mine.

It's definitely a bit of a mess now, but for-6.5/block also depends on
these changes and make further tweaks on the block front.

for-6.5/splice is stable, so just pull that in?

-- 
Jens Axboe

