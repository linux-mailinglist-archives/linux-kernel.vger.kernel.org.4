Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DE873E281
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFZOvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjFZOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:51:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74C610D9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:51:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so1891208e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687791091; x=1690383091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9gU1jNjcV6TD928B0r4atzgfh+TbbilOvGXXldqDgK0=;
        b=P4arqQv9iik6Y23luPjXnYhW+FqmKPWyPqapmmXGTxdsyuQB1RYBMkM594au8k4UUn
         tcf1MdtQFSssHm/+NapY9LqmBUhxi5vYlyek4p4UJ+W9W8gydaPoYfYX+wgdrIsSl+Kn
         IJ199GQu/s2g1BAdz8LLdFaVTmge05hmdPc4Lm7tlnvaNjldEtPt7rAIeIo1mGh9UkBs
         REojplSiwcdWHdAZosRvCZczNR4umvbTyeqqpE84zBtUL46ljXxF+nfj1tGBYVENGrla
         2pj0ui50zmvJhrVkoez2d+YVu5v4ZU2LdSN8mX9G94kflAdom8mVifhmhjq7E8OkPh7+
         jzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687791091; x=1690383091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gU1jNjcV6TD928B0r4atzgfh+TbbilOvGXXldqDgK0=;
        b=WRnrcOFS71stSuVFmb2V0OAAWYrSSPqXpArfLBrGdVttQOc6QBtIlhr61GZ/kAovV4
         /op/y7jqyoDMFRfMjqo8vEu14/ZpKuyDVQSeOtQbm5LZPF2Dp56UfzFGZRKjRM9od6b3
         5Zsw22kyfGDmEauLua6QMFpyM/6hWeuaSQYTGgCxcAZ+fCTnLQ16K0rd3ZTstXU512Jc
         SvYdSewcMDJZlVpw9OTU3S7Mt+c4d8V2u2BxNX+DpSYbcDV5smQqI9X6AbtIFhWnH6kf
         YdeQEqiBp3knNL+ll9XKAjeImEdDjp1nG4yX+khjGibYZn6Ou43NLnnH4Hk+hSM/eY5+
         GpAw==
X-Gm-Message-State: AC+VfDyt9YODbqzyS/LY4H3TlTjnNtiDPxNyZcn6nlG6yiOKXX5pkHUz
        Dk6Udpy4aNORHQfgRYcoNvO4Wg==
X-Google-Smtp-Source: ACHHUZ6CgCGY0Hct7p+o+Enwx0beOYHQwNpJ6fFz/NAiG9n54W1RtKHH9zAN0ucOoL1tyevnuFlEkQ==
X-Received: by 2002:a05:6512:3b95:b0:4f9:5d2a:e0f5 with SMTP id g21-20020a0565123b9500b004f95d2ae0f5mr12257430lfv.19.1687791090735;
        Mon, 26 Jun 2023 07:51:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m8-20020adffe48000000b002c71b4d476asm7611864wrs.106.2023.06.26.07.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:51:29 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:51:26 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        dm-devel@redhat.com, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [v2 2/4] dm ioctl: Allow userspace to provide expected diskseq
Message-ID: <79fdecc7-138f-476f-bc40-3603aac408ad@kadam.mountain>
References: <20230624230950.2272-3-demi@invisiblethingslab.com>
 <3241078c-2318-fe1b-33cc-7c33db71b1a6@web.de>
 <ZJh73z2CsgHEJ4iv@itl-email>
 <e42e8115-6f75-447e-9955-ca4ad43ed406@kadam.mountain>
 <c1b84520-94d2-2c5c-6eed-2a0697c086a4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1b84520-94d2-2c5c-6eed-2a0697c086a4@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason why Markus was banned was because he doesn't listen to
feedback.  I've told him several times in the past week to stop
bothering people who are trying to work but he is not going to listen.

Meanwhile, I have seen Markus fix bugs so if he wanted to focus on
fixing bugs he probably could.

regards,
dan carpenter


