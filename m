Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A86690216
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBIIZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBIIZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:25:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC424A1E7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:25:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id dr8so3958250ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 00:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GU78AT4n7kDFxKHZzo9IaZ7F4p9Xxe8hUFOTKp9kpB4=;
        b=SVKBYou6NW91MaPHF7P3e/iytp+4yGy/jutT9kqWLTfx6GDqKMmJ+mfPrMg5/bo+6n
         1GJp2ZcdMK82kU8Gr9ecKePCU7y/F0waPDaBVOxMWfkhKjzHStzqhipbzD+Qid9Rs0F8
         PaezREMnQOX51UpRUW2JOTRBfemic5LKSqgbatYp9bi+9shpwJH9dlHYTHSDcLEYSvuX
         ShgdaCAUYxSDbwYzfBSEfykT8TUe2iyef/0fzE6twWfNvf9AWI59lo5W2547eEAEZ5Z3
         dNa3iU/DptSsdNC21ti8+RB4gQJ0yx/okunwL8D89H7T6t1WX3FU0KnxxXXoGRQjnUFO
         xgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU78AT4n7kDFxKHZzo9IaZ7F4p9Xxe8hUFOTKp9kpB4=;
        b=moRYPSCwAQeL5x89uVD9jTFp0CR0DuwNj1AZxwzmkYevwTu55DGzWKcGg2+uQTYh2a
         8upNIQpE/61mI2JZyPPpbI3WVGSom7MzxWuSyuviIFl1X2RtBYMS4TWIvofDhJhpFv6X
         0rAiF4aQIJzy1r32wHyxQQLlYy+ahl0GIVLf0pCSRgNS9YhhNiyscDR8XO3XXbsCuFF2
         nVOsWY24yFoGeVzlGIi51rToj6SDir7X2fK3O+tPmynGOa6WPo6V9A4r970I4v7k9xOo
         wNwzLJHc3nFC08upueVEeWaQtFJQMUI9esQcbIKDY9bL/HMrasehAZxHnWis8JWd49Ip
         JtBQ==
X-Gm-Message-State: AO0yUKXV+gThAIZEpczucoXCMmLtS9UNLI7234oYgOLPRV9sA8gDEyBl
        eTYHf3gMQJJCoqOH0GYPDKWqUA==
X-Google-Smtp-Source: AK7set9aY/xPOLlwLfYkbN9QbBoTYGoYABPbfJLyKcL8lnHclFz8WmS/2yGuLyJwlVX6bytWL0Pgbg==
X-Received: by 2002:a17:907:8b94:b0:87b:d402:95ac with SMTP id tb20-20020a1709078b9400b0087bd40295acmr7151059ejc.27.1675931122287;
        Thu, 09 Feb 2023 00:25:22 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906c08d00b00878003adeeesm576373ejz.23.2023.02.09.00.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 00:25:21 -0800 (PST)
Date:   Thu, 9 Feb 2023 09:25:20 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, palmer@rivosinc.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 1/2] RISC-V: fix ordering of Zbb extension
Message-ID: <20230209082520.solukez3jrshv3qo@orel>
References: <20230208225328.1636017-1-heiko@sntech.de>
 <20230208225328.1636017-2-heiko@sntech.de>
 <C32D5495-F772-4887-9CAD-66206ECCFC3F@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C32D5495-F772-4887-9CAD-66206ECCFC3F@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:20:10PM +0000, Conor Dooley wrote:
> Hey Heiko,
> 
> On 8 February 2023 22:53:27 GMT, Heiko Stuebner <heiko@sntech.de> wrote:
> >From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >
> >As Andrew reported,
> >    Zb* comes after Zi* according 27.11 "Subset Naming Convention"
> >so fix the ordering accordingly.
> >
> >Reported-by: Andrew Jones <ajones@ventanamicro.com>
> >Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> The whole "getting it wrong immediately after fixing it up" ;)

Hi Conor,

Do you know any patchwork savvy people that could whip up a check
for this array? :-)

drew
