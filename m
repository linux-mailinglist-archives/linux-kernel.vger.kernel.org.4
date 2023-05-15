Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A9B702DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242317AbjEONU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbjEONU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:20:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4542F30CD;
        Mon, 15 May 2023 06:20:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24e09b4153eso8725800a91.2;
        Mon, 15 May 2023 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684156801; x=1686748801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6RkhyJPMH/Wu/wMMVUSEIITW0FPN6tpl5OQ4Pb9FBM=;
        b=nC4Z21p7fJePKhLmKwfLyfWNlqgCZ8hfdD8ZVZhZ+N2zSwEClmTGANiCGUtJ+dMYfZ
         wS/YW3QNSGAvXQ6qmErNhJt+EzcBPEkS4cm/pv0fxCS8YuQyE83CBU0DDkm5L7/BCAnN
         YeDGvZ85VbW6Aha3twQSNajh0n5n2F0COzsynGfEeQYHQoaMMHuQPX27YyaqLiRS/k2V
         Scwdj6g/Tr4jFdw/l95zh8S37q8l1K5aqWnqJ5gXu6nlkUfWt4nfiqtQ8ljE9HPDWAFH
         keGp3HSONZkO2Q2sYHXiR8rh8JF0GxUxg/djWVhHRtROINYEyC/4lpdCOxfdfCgrKCZz
         NgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156801; x=1686748801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6RkhyJPMH/Wu/wMMVUSEIITW0FPN6tpl5OQ4Pb9FBM=;
        b=h8uOtRCZL1o5+FRTI8GPN5OihlMm+vUBf65566GmaNDxRt89b3uPP6G/aidQpAW3eC
         P1NhrFxvtWLICS0bwQIdmo9kM9+9470zHTXXAjOcbGuQxPeKxmEqhVFg+74FzhoS/LJq
         I5HaKpbe+4gcgpjL6MzdS4AN8AuMIDrOjVv1+x3nd2cmx9Rm1j29O/EAbhS5AP898IsU
         3SN/G4DEeV1GZ4anhUXf3+3ha8lF+4KBOXssLjPGQM8uJBD8kQMWu5Wihtr3cagXodn5
         M2WEAC1/EQcTEAmsridjJKG9H1dvILAnFFoxxjiAbOFoBNlMaBjWpENOBgLjUfWxspWL
         viSQ==
X-Gm-Message-State: AC+VfDzQQ2tbxWQPWMSOc9B8FbIihB4Ka2Z09Rrhwu0Om/2j2DxCQs+Q
        mxqlWJNIA0Zv25P0/iNd6IzX3e3TcGQ=
X-Google-Smtp-Source: ACHHUZ5u2ZulkIWrELEMPEiR7wUwUMTHfk9V5c2hLkm/vRkpuIgN4vfgYDx192z6qgDlrW+dck6omg==
X-Received: by 2002:a17:90a:fb8a:b0:252:a0d5:ae91 with SMTP id cp10-20020a17090afb8a00b00252a0d5ae91mr13577490pjb.42.1684156801442;
        Mon, 15 May 2023 06:20:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pi5-20020a17090b1e4500b0024744818bc5sm13955567pjb.9.2023.05.15.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:20:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 May 2023 06:19:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     llyyr <llyyr.public@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6683) Add another chip ID for NCT6687D sensor
 chip found on some MSI boards.
Message-ID: <350dc86f-8341-4c3d-a3f8-0f4f5568ae77@roeck-us.net>
References: <20230515092546.21154-1-llyyr.public@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515092546.21154-1-llyyr.public@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 02:55:46PM +0530, llyyr wrote:
> This value was found on MSI Z690-A PRO DDR5, with a NCT6687D chip.
> 
> Signed-off-by: llyyr <llyyr.public@gmail.com>
> ---
>  drivers/hwmon/nct6683.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
> index a872f783e..5df9b9ce7 100644
> --- a/drivers/hwmon/nct6683.c
> +++ b/drivers/hwmon/nct6683.c
> @@ -14,6 +14,7 @@
>   * nct6683d     21(1)   16      8       32(1) 0xc730
>   * nct6686d     21(1)   16      8       32(1) 0xd440
>   * nct6687d     21(1)   16      8       32(1) 0xd590
> + *                                           (0xd592)
>   *
>   * Notes:
>   *	(1) Total number of vin and temp inputs is 32.
> @@ -71,6 +72,7 @@ static const char * const nct6683_chip_names[] = {
>  #define SIO_NCT6683_ID		0xc730
>  #define SIO_NCT6686_ID		0xd440
>  #define SIO_NCT6687_ID		0xd590
> +#define SIO_NCT6687_ID2		0xd592
>  #define SIO_ID_MASK		0xFFF0
>  
>  static inline void
> @@ -1362,6 +1364,7 @@ static int __init nct6683_find(int sioaddr, struct nct6683_sio_data *sio_data)
>  		sio_data->kind = nct6686;
>  		break;
>  	case SIO_NCT6687_ID:
> +	case SIO_NCT6687_ID2:
>  		sio_data->kind = nct6687;
>  		break;

The checked value is masked with SIO_ID_MASK, or 0xfff0. Why would it be
necessary or even make sense to compare that masked value with 0xd592 ?
Please provide evidence that and why this code is needed.

Guenter
