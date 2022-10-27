Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29426103F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiJ0VFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiJ0VEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:04:39 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713742EF0E;
        Thu, 27 Oct 2022 14:00:18 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1322d768ba7so3929637fac.5;
        Thu, 27 Oct 2022 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDrH9NbSmg2MxkuWrwWx7O4eXK81KiWq00+glvya1gY=;
        b=I5rJpeCz7L3Vpb7k/Dxby7j2LLzmw0Wo5Er1Tl+UqPxpPOAXosKX+jboAIkPDYTki0
         um/Sa9+ScWmJWa9X5eKmu6SQF1FLplALqsxSQdz229GnRoAIibGdsXSmaOelagRWI3pL
         sJvmX2jMr7hy6y/O2YiYK2vQFQOpwxzUpkciJ5depcoBWWEq5/mdmTCPu9niPgPo4YzZ
         0cwMjtlB8QGR82TBH+sOKUvBpMw2LbkFGxVAslMcbbKiU+llEL2btSnkI5uvkaBCIaYm
         UuIzT5WiwjROKZ/tI1W1/qMv91q4mb6zzHx3SJ8aizZAWDMh5yoOOF+6EePAH7WJz5HU
         Lkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDrH9NbSmg2MxkuWrwWx7O4eXK81KiWq00+glvya1gY=;
        b=tjOPK1R8x6Dix5k6J8SaBv/UaeI9FN6hq6g1rbvHD8o7pKM2GR0JcSqp4i8cnUOEou
         ayvXZiq9v+6OJGhrk2VeXNUHA289UgVjgWK3qWbLaq35ICy/9x8M3voZCZDyX+T7l2rL
         hLhdGWHeGlVnIpH2uwQGfAc8YMSUMIRbUMvDl6Te2/rriAutRH1CUBUsBnt0bNRoQmpN
         xUmsR3BM+iemniF+Poy2MIbDQbQKFAkYMJIbl0OXbublw8V/ZHXQnJqpCEgHRMy/qNd0
         7f9zgDCbdPScxMt8AnXmyAKLrFWxgGIjZlrGB7XxTMDZXLZ/Pfv3c3XqcLMJLvroUQZw
         xMoQ==
X-Gm-Message-State: ACrzQf3Rx0oNBzXttoKSrAv/zsbTshqBwSvZBRCnYmLOuz49/hp3d4HT
        fT8WhIo7FWituaoqIrByq0k=
X-Google-Smtp-Source: AMsMyM7ZFPu3XMVRljKKEsD87evoffo4TxYuSL7R+ljCGk3sZMJKHHUt0o4m7FmYCkc/BmeCXd661g==
X-Received: by 2002:a05:6870:e307:b0:137:542d:7360 with SMTP id z7-20020a056870e30700b00137542d7360mr6880014oad.78.1666904418270;
        Thu, 27 Oct 2022 14:00:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 126-20020a4a0384000000b00480816a5b8csm879646ooi.18.2022.10.27.14.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 14:00:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 27 Oct 2022 14:00:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH -next] hwmon: (smpro-hwmon) Add missing break in
 smpro_is_visible()
Message-ID: <20221027210016.GA1938309@roeck-us.net>
References: <20221027195238.1789586-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027195238.1789586-1-nathan@kernel.org>
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

On Thu, Oct 27, 2022 at 12:52:38PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   drivers/hwmon/smpro-hwmon.c:378:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>           default:
>           ^
>   drivers/hwmon/smpro-hwmon.c:378:2: note: insert 'break;' to avoid fall-through
>           default:
>           ^
>           break;
>   1 error generated.
> 
> Clang is a little more pedantic than GCC, which does not warn when
> falling through to a case that is just break or return. Clang's version
> is more in line with the kernel's own stance in deprecated.rst, which
> states that all switch/case blocks must end in either break,
> fallthrough, continue, goto, or return. Add the missing break to silence
> the warning.
> 
> Fixes: a87456864cbb ("hwmon: Add Ampere's Altra smpro-hwmon driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1751
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/hwmon/smpro-hwmon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/smpro-hwmon.c b/drivers/hwmon/smpro-hwmon.c
> index ee54e21c2c12..667e88b6bae5 100644
> --- a/drivers/hwmon/smpro-hwmon.c
> +++ b/drivers/hwmon/smpro-hwmon.c
> @@ -375,6 +375,7 @@ static umode_t smpro_is_visible(const void *data, enum hwmon_sensor_types type,
>  				return 0;
>  		break;
>  		}
> +		break;

The alignment of the break; statement above is also bad, and a default:
for switch (attr) is missing.

Guenter

>  	default:
>  		break;
>  	}
> 
> base-commit: 0ffb687b6508c36a17b99bdaf014b38532404182
> -- 
> 2.38.1
> 
