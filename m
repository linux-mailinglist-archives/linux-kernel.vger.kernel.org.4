Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADC26E3974
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjDPOml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjDPOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:42:38 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFD63ABE;
        Sun, 16 Apr 2023 07:42:31 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b18so89425iof.0;
        Sun, 16 Apr 2023 07:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681656151; x=1684248151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwuSmhhIXsSx9xZ+zrvYmUDtFIPatS54sEm7b5OSFyM=;
        b=Pz9lpjkf9ChUWBCF16hmOSxxXyIslsuWXrLI5kKLxcPsnR3wKaVBTcooV+pHryEetK
         9V44OYyXIV+KOhusn/cB/Hc7lU0JkqDpcSOCLAmKQIOiuTVHpojt42kmQft2Bu4hXIyf
         Xoa0r6Zll8AC1Irk8OoNFiH1SDRMXWFgOpo28oKOcB8tQHljQwvoiPa+KV7QQip7SzOS
         1m2OaqRvmjpEshCLTOjpgG2mrEOp9XOyjF1Balgu2dCe1lPDGQ5Lslc8rXlqL9khHYP2
         acS/NJePMaSEZKO8fFB4qBF3v36gAPnz8GXX8gmDu3vIuHn2W+KHoOdJw5hmsdKTZeBR
         NgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681656151; x=1684248151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwuSmhhIXsSx9xZ+zrvYmUDtFIPatS54sEm7b5OSFyM=;
        b=hiFnpDx40sVThp8WgLTCcKlJuqvz22y+cujnhQ2yBqIBAI4WTKrHgIU892zuz3Lu5V
         w68QopmvX87AxoLHc1y5CvCyDEktaeIBA1uVvlI/GtoZMJ32SJcxV1zz13BH3At8yLrk
         S1A7WdBQXr7MVAKMMHEMbGuHRz0ukBMiCf3cG1+ZD2vtQzqkUtQbhavrvmPRWxB8wS0c
         4eVLMScaeFuKT0sk7PvVcrua4Wv3NYwMJr7kcVSXCrzYBOS493Y/fzTzl3iexpF9G7jM
         nfJk+Ppe2rurqyG1DgNPq0uZwVG+aKY+zzTqVSPrEdU3IRAQbxFvDSev/CXRNh+lYA7B
         x4BA==
X-Gm-Message-State: AAQBX9dIUBTC5FLpQ7AVUCVK78l3/8X4ytIw3+AS/TDO2Z5uxFE9fVo0
        6fs4DMiKXVdTSJwgn4I3MKM=
X-Google-Smtp-Source: AKy350ZANvGqlgTZ3Fk4+HpsHCN3WxblCYATxvRUBvDwfGM71Gp+EX4sM7nmxMFC9aXEWmAFYxRdYQ==
X-Received: by 2002:a5d:81d6:0:b0:760:ced3:4481 with SMTP id t22-20020a5d81d6000000b00760ced34481mr4299145iol.4.1681656151164;
        Sun, 16 Apr 2023 07:42:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m9-20020a6b7b49000000b007046e9e138esm2597376iop.22.2023.04.16.07.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:42:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 07:42:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 4/5] docs: hwmon: Add documentaion for acbel-fsg032 PSU
Message-ID: <4f59352b-725e-4fec-95bc-0b2080841eca@roeck-us.net>
References: <20230413132627.3444119-1-lakshmiy@us.ibm.com>
 <20230413132627.3444119-5-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413132627.3444119-5-lakshmiy@us.ibm.com>
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

On Thu, Apr 13, 2023 at 08:26:26AM -0500, Lakshmi Yadlapati wrote:
> Add documentation changes for acbel-fsg032 psu
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>

Applied.

Thanks,
Guenter
