Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718216483A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLIOTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiLIOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:18:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ED529CAC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:18:44 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so3547750wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rqRoXzIwEU1zj8bbDdo1JhYsHCe+Ftd9l7ZfInZw3d8=;
        b=czdanGLrDAyClU5QU5AQxcinaoDoWniKhl88AKAL2HIY+ifUSLmSjhdLqGEpOECfRj
         Z3v4v2QcgJqutrx7bw7vfyZBEzOYSgYDvxpViB5D11WTxY7I5zqdG/KoMpqpK/Yx6XBC
         qZufVQ66nL84yglPGwgRlkIMGWw8Qz5Ke8NirlX8CgkM0nRdTGTTuCi2PJVwypAHnCOo
         iq5Y8kf5ygbAEsRE3fnrim/nYs4WX9utVoHrr+t4U4cHBWw5jyO3/sPlCJGyiKXu/Xls
         ulVZPZhwOEdl28x8OySAPsX4N2aCPAnbqjyCSoUKY3oqx9muAK29mCUvIAsmoZ3+DeQm
         T6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqRoXzIwEU1zj8bbDdo1JhYsHCe+Ftd9l7ZfInZw3d8=;
        b=2xMLKuZiS88GGcH2IbtNVEnLgF7oSbYJJuaFzfHVONKUCZhMg+FmaZyPQpkYms2ofR
         3bzz618GijkqwMJFyFHekaAbKS2CSaf/ny1Xnhg7+zFy+Z+Ps++S3q3Qszp63hUSeJx9
         jH3o58lyCpqo0vsNPoniFl4xXBmyyEyA5BSjyDbHq1x7cQxs0Ey+O+ZHR9+tMHZl9f1V
         t8WM2N4sXTieS5YILd56Fjoq7BA51tCrb2EZX9USduuJT7Pp32pq6xvHeoXk0uoA5Eb7
         WmNwNcLwMezgG1MKj3G8198TuZV3Fp5nU741xpdNO7cKna8Y63lRpc7fr7PSdUgeEsG+
         ubcA==
X-Gm-Message-State: ANoB5plK6hgnpApuvT3UWQqzjuqbMsQIjR46BLUAHlFp0rVQ3c7v8YST
        cA/2tOWoVal9jaZiEEKE1trgAw==
X-Google-Smtp-Source: AA0mqf5HnEezPwRXRfAv6gmx0BINo5sfONCkIqxCk4H/YcaCk8vM6p19rHCM888dibQN+ISegErqXg==
X-Received: by 2002:a05:600c:1d15:b0:3cf:c2a5:5aad with SMTP id l21-20020a05600c1d1500b003cfc2a55aadmr5210391wms.14.1670595523376;
        Fri, 09 Dec 2022 06:18:43 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id q3-20020a1c4303000000b003cfa81e2eb4sm1897390wma.38.2022.12.09.06.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:18:42 -0800 (PST)
Date:   Fri, 9 Dec 2022 15:18:40 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 1/2] usb: serial: add support for CH348
Message-ID: <Y5NDwEakGJbmB6+b@Red>
References: <20221114073736.672194-1-clabbe@baylibre.com>
 <20221114073736.672194-2-clabbe@baylibre.com>
 <Y4DETJvl12YfnMxF@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4DETJvl12YfnMxF@hovoldconsulting.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Nov 25, 2022 at 02:34:04PM +0100, Johan Hovold a écrit :
> On Mon, Nov 14, 2022 at 07:37:35AM +0000, Corentin Labbe wrote:
> > The CH348 is an USB octo port serial adapter.
> 

[...]

Hello

Thanks for your review, I have fixed all problems.
Thanks again for pointing mxuport, the code is shorter now.

Regards
