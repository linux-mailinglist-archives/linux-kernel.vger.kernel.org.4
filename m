Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B808A6DB042
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDGQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjDGQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:10:21 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C36BB8F;
        Fri,  7 Apr 2023 09:10:17 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-18412684c50so1974761fac.5;
        Fri, 07 Apr 2023 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680883817; x=1683475817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsLvnZPjZzg0dHWcEvsz63QWITXOPT4dhDFyS/J5cWc=;
        b=gl+icpuxByBdWPer9h/dOry8KXl32HRBQLE40aGJLLqi+44Q+hVcSJ+hlnToLJMmbu
         vLbST1fNCMZd9SfOVKRN6pDhJ72ae7qaQ31CT8tIVih8H1bGXxRQu0EOBbW2AUTNHIle
         SVFiUevgUGxYLKOChPpyBtgsJ7kqT9c7r00yLqbj1YD9EJ5b26UaAQcP5iZEZTlwf6zO
         dFM6NxXZ/FviheJR1x/hx/FpnABo/LYWFJHhhFPFIoB9x5H2A/NKgb2kRF+QAiczGPbP
         FvXTeePNqzKsO81MgYiW6kcBe7z0fpUAfkXUf6+mQXXm3pY1ayEqwWQ1dsqwTcCfse5y
         /ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680883817; x=1683475817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsLvnZPjZzg0dHWcEvsz63QWITXOPT4dhDFyS/J5cWc=;
        b=2bpUuMl9IKnaqAv94cYHjomupp1A0Gha3FmR9zRUFhOoBSo97VsSgiuB6HvFa4/Fz/
         ec7WsLy39Yuj5IHr0oQzljHg2SOFSLmpoC1MavtSsMaVfF4UE7YlueuAAtx09aCyy/r7
         clcKsMtsvEVLTZbe/UYNEj4DoH7W9GWGD0ZD9GQRazRkOo8y4Se4BA+1aDCL560UPI7p
         i3CnENN/DPIgRQnU2W28BJFWx31Bo713EH7QltiF9ZM+5wueUDZzR8thOFPOgDcKpUL2
         yKXRtTW0dY20en1CJNHGDyQQqnvhSaMb/psEeUddvRXVfwjRlo6S6srtSxQOJk9KJHhM
         M5zA==
X-Gm-Message-State: AAQBX9e/XYjqeaXk0PHkt9m71Xpgq/75S6q7W4H0bP1EGY+IozfHQ0qn
        9ZYTli0wR87otmkh92RmL9eeUQP7NPg=
X-Google-Smtp-Source: AKy350aQmpkzuIJCBwpF9hC39OKaMl5RRnovDFu3wk8lFMdFEt5mr/xYfzxksZ89wKZQ1TCIRktEUQ==
X-Received: by 2002:a05:6870:304d:b0:177:824d:e944 with SMTP id u13-20020a056870304d00b00177824de944mr1634507oau.51.1680883816908;
        Fri, 07 Apr 2023 09:10:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j16-20020a9d7690000000b006a2ce5f3641sm1834758otl.8.2023.04.07.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:10:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 7 Apr 2023 09:10:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: [PATCH 2/2] hwmon: (pmbus/ibm-cffps) Use default debugfs
 attributes and lock function
Message-ID: <9c3d277f-a23b-447f-8850-354f54deb07b@roeck-us.net>
References: <20230405145230.68631-1-eajames@linux.ibm.com>
 <20230405145230.68631-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405145230.68631-3-eajames@linux.ibm.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 09:52:30AM -0500, Eddie James wrote:
> Switch the driver to use the default debugfs attributes instead of
> ones that provide the same data under different names. Use the lock
> functions for the debugfs and led attributes, and simplify the input
> history operation by dropping the timer and lock.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 273 ++++++++++++++------------------
>  1 file changed, 118 insertions(+), 155 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index e3294a1a54bb..2d7ec00e047b 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -18,12 +18,6 @@
>  
[ ... ]
>  			}
> @@ -225,29 +183,27 @@ static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
>  			rc = i * 4;
>  			break;
>  		default:
> -			return -EOPNOTSUPP;
> +			rc = -EOPNOTSUPP;
> +			break;
>  		}
> -		goto done;
> +		break;
>  	case CFFPS_DEBUGFS_ON_OFF_CONFIG:
> -		rc = i2c_smbus_read_byte_data(psu->client,
> -					      PMBUS_ON_OFF_CONFIG);
> -		if (rc < 0)
> -			return rc;
> -
> -		rc = snprintf(data, 3, "%02x", rc);
> -		goto done;
> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_ON_OFF_CONFIG);
> +		if (rc >= 0)
> +			rc = snprintf(data, 3, "%02x", rc);
> +		break;
>  	default:
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		break;
>  	}
>  
> -	rc = i2c_smbus_read_block_data(psu->client, cmd, data);
> +unlock:
> +	pmbus_unlock(psu->client);
>  	if (rc < 0)
>  		return rc;
>  
> -done:
>  	data[rc] = '\n';
>  	rc += 2;
> -

I hate to say (repeat) that, but please refrain from whitespace changes.

Guenter

>  	return simple_read_from_buffer(buf, count, ppos, data, rc);
>  }
