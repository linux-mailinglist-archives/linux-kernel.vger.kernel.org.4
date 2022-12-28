Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A6657E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiL1Ptf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiL1Pta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:49:30 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A60B183A0;
        Wed, 28 Dec 2022 07:49:30 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id y194-20020a4a45cb000000b004a08494e4b6so2722699ooa.7;
        Wed, 28 Dec 2022 07:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9yNgso4/2tGuxDhJOSzSMkE0B06F5BoY6elkTEc6B5M=;
        b=plmqHno/iv3Mtq44LB4y4r61juNS8QnY7BzlSGBVURh1Lpc2Jy4iIFo3EDXAjs8pbm
         VLeZWuWWzBgpHT273yWttlW7ipk6IV/vXjHdt3p3Q2ae4Cvj408AlRBS3ByUcKTkun8m
         WlWkXh+xK+GLy9UOaQMELqAranJGhJzH3+muWM5C/AAZHFXSnqQx14uBjokb4FDY0xIN
         RvCho9nRKs3hOYNZ26wfS6mWinEMF8+Xm2pUP+jPXzPfPVGvkq/cbJ/NAdHyJ7PEpCq5
         ybb6epH+Qx+rVzcCVYzgXbvhDaLnFOtSmH1/F2G2j2kmw3rv2MB5pwm1OV/pjLb5S5XH
         knOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yNgso4/2tGuxDhJOSzSMkE0B06F5BoY6elkTEc6B5M=;
        b=upK3Ktn655cQVQObrhSUFvz3RQB6sqzZeinjmRfHXSfEJeiPgVfRD3n+Nur7f1WA3I
         2O6oYwwIQjpvtYf+fdyeQyiNqfTs+UzTnbCWOvVSAx4CH3coPQAdeC3hGOynF4TLIPSV
         Ep/cQ4AQ3LviOF4we9E7NF0zMU1cwpCCKI08bGHBZecG6ZZXFPst6SLF/yNU6gMDoywk
         g8Vv1HzIbww9vPpGUaetvDD8cwbYQQ//biXqc8SF7nJ3xYfnVufD7krECWBJB+f7ZbLZ
         HH7mnvjZwemx1AAjM9fdm3ndpb427yd6taw1Uahht8oxKAXXJM2N31XVEJBYS88wAPAu
         6imQ==
X-Gm-Message-State: AFqh2krBtg4yxDYydaFhs8LyPqZ37L3euf+HoBz5/+Erg5bV40giaoaz
        R2VSicKZuPRkqPnlcQQvMlr5LSKdJ1Q=
X-Google-Smtp-Source: AMrXdXsfrEglWnLfZmZg7PwH9t1/e8f9n8ObSuFJOrmeBtX7SJbHdylpBgeBnoWVawrqtRh3NgQa3g==
X-Received: by 2002:a4a:da55:0:b0:4a3:9bd7:60e9 with SMTP id f21-20020a4ada55000000b004a39bd760e9mr13367499oou.9.1672242569715;
        Wed, 28 Dec 2022 07:49:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a32-20020a4a98a3000000b004a3543fbfbbsm6340032ooj.14.2022.12.28.07.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 07:49:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 07:49:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: hwmon: Use file modes explicitly
Message-ID: <20221228154928.GA3919272@roeck-us.net>
References: <20221212141245.52935-1-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212141245.52935-1-samsagax@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 11:12:46AM -0300, Joaquín Ignacio Aramendía wrote:
> As stated in the mainling list[1] and by checkpatch output, the file modes
> for is_visible_func should be returned explicitly. Change that in the
> documentation to avoid confusion.
> 
> [1]https://lore.kernel.org/linux-hwmon/506a6e7f-4566-2dcf-37f3-0f41f4ce983b@roeck-us.net/
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/hwmon-kernel-api.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
> index f3276b3a381a..26cf55303c61 100644
> --- a/Documentation/hwmon/hwmon-kernel-api.rst
> +++ b/Documentation/hwmon/hwmon-kernel-api.rst
> @@ -299,7 +299,7 @@ Parameters:
>  
>  Return value:
>  	The file mode for this attribute. Typically, this will be 0 (the
> -	attribute will not be created), S_IRUGO, or 'S_IRUGO | S_IWUSR'.
> +	attribute will not be created), 0444, or 0644.
>  
>  ::
>  
