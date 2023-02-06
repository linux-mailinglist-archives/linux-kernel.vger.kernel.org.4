Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2496268BBE6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjBFLms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBFLmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:42:44 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CA91DBAA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:42:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10561846wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mcLZp+bwHljE1RPuf6xDhCdiFhlDxm+3HKZwHetgGw=;
        b=S1/cNS9JWmRCZjJP0bvEApYHgfPv/5Mq/zmU04VMCzjhe03zfE/kTViHbevV8VeLFR
         VVZOmmsX8Vj+MgINVGGJ5zj1Xo/DQKz2nWCWBoMT0t1iiwlchcu4Aw8A2Y9YTE6o/FH2
         wL2NXNHmCI9o/ISJc8HzhjPHGlauMuGSNVUZN3ZrQLw/8cLzLL97c1R72iH+jaoxkJLV
         dzf96GbhIS+qtyumbaTEEvVjuhLwHUgQPwFwtD02wG59fmo7DHGzAJPwTbCCvkAmQniN
         RmQ3W3VoE3Z37TcraP0c5v4olmO01gXh3ukNu80/tDe/eg1VVi6VKhQjvs+tInOAAK/R
         5Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mcLZp+bwHljE1RPuf6xDhCdiFhlDxm+3HKZwHetgGw=;
        b=Vp9QD82w6BzlXVw/yYAwwLetn0OgpYJO+sBO/cRfuqKCqfCqZKJ5MiP045JIFCHMT9
         irCpr2iLmdHikCTZAna6p2b7K1sMcMjWnlK/iMCPE+svX2smgkiNPHaR3kMPw0NuCUaB
         jfFsOo0ACHIiL7VL9k/UQtWgMhYhnCpXXHPsNU3Su6HgzEcxOuSpb3EGkKGj3N/T6nOX
         6VJanlfgWWJ6tGcE56FHHnrD2CwIYspiFhancxp5KVWR6UE6SXHqvAmo3tQtmevQGkih
         Uesc/Nm7lo0AuAgXfllT6DwPjwPlZcuhY86e4DwMbXscndaFyiKhbQzhGtxrEWTE9Y3K
         dNTQ==
X-Gm-Message-State: AO0yUKVOthV/z7est5FFMZ55pbebi0Ug4U+G65N2eC8qrg4zVDwyx4JV
        bnnlnXNePfUBQfAlCPxkY3qMBg==
X-Google-Smtp-Source: AK7set/0e8rb0pkCcbZULGmSmISHb9E98R7iG5wsZXc2LS2PbucXN5Ox8X2GEu4jmltN0YSmz+C+0g==
X-Received: by 2002:a05:600c:1d99:b0:3dc:d5c:76d9 with SMTP id p25-20020a05600c1d9900b003dc0d5c76d9mr20747824wms.0.1675683761383;
        Mon, 06 Feb 2023 03:42:41 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z17-20020a7bc7d1000000b003dc3f07c876sm16116888wmk.46.2023.02.06.03.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 03:42:40 -0800 (PST)
Date:   Mon, 6 Feb 2023 11:42:39 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: hx8357: stop using of-specific APIs
Message-ID: <Y+Dnr7bzJ7XDdXH1@aspen.lan>
References: <20230131225707.3599889-1-dmitry.torokhov@gmail.com>
 <20230131225707.3599889-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131225707.3599889-2-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:57:07PM -0800, Dmitry Torokhov wrote:
> There is no need for this driver to be OF-specific, so switch it to
> use device_get_match_data() and stop including various of-related
> headers.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
