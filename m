Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE3680150
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjA2UQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 15:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjA2UQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 15:16:09 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D761C586;
        Sun, 29 Jan 2023 12:16:07 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id e12-20020a0568301e4c00b0068bc93e7e34so971085otj.4;
        Sun, 29 Jan 2023 12:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcUvGf3SnNJxJpngwgS9E38WXihDAHpNbeo4S+i2+60=;
        b=cYD7YfYm0ILqmo0ok/tIMKHHzSl5YLmOYhTocxYL5rksY2xPX+uTYSGcUC3OCK7jdm
         2REzNnZCJB8GEFqp1oSI6E8uSjf7GjO9n6eVtQ590WNwheyogkFr82/X/Rvu8gSsguaJ
         fdF5f29h9dewTOX8xkLqrmf8yT4Iu6IqN9Z5HXc0R/h88R2pCcH8gYQ7j3dfqeG9Vg0B
         EeRMCT7Pgl1Hi6XMWHcU1MpAjphreZ4fDdH/V39ktDJCzE7LX01HXyFsJn5gT7LQxX3t
         yOT3sW1rQP7NTPdTPoWOWv20PLzFwGSVT/luUO+/HvNvAl5gPx+MZKpuTeY1jpWik2n8
         a2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcUvGf3SnNJxJpngwgS9E38WXihDAHpNbeo4S+i2+60=;
        b=CW76y+6U+5AgNJeDuN/DWxxBlrPKteAfaEuUdgutmkOYELEkai7t+nAXfs6kyZkdNV
         C4orNTdB+OCbqDZdtd2l2FqpmTfHahL/bwKrWO84EbvIe2N2yb0hI6CFsZI7YHAFYSX9
         QTpNfq5PSWGklyDBq/v6NOjc1EH5zNumbOsWAJtkegibv2aicGY+bZCEjIxCXrJb5hd4
         jS6OS7DGFAoYbzkk9hf3WRXi7X85Nyc1RfMP1AEz9S/o+wlozYQ8pPgWEi2HFS2l6wvW
         BljqeoWxf9iG9RJrFzKhbpAJrxuD0awUBxkFtXbYIYfbt9Dpb0g13cQtBHK5OJOuwsT1
         FzFw==
X-Gm-Message-State: AO0yUKXLI3FP8q47HWhcmaN4ODXkq/OocpZT/9YFBrKW6YKYEWDRuATK
        6yg8uZvEGioXY1qDCY0igUvB0eO5T9k=
X-Google-Smtp-Source: AK7set+GkYHlOmIsVlnTVKZnuTEDSVDrRNryjt+RdJ9ezxZnho6Hgqo1Wds3ZKfQckXmLzs7Pme0vQ==
X-Received: by 2002:a05:6830:4d4:b0:670:9cff:64bf with SMTP id s20-20020a05683004d400b006709cff64bfmr2901235otd.21.1675023366301;
        Sun, 29 Jan 2023 12:16:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c5-20020a9d75c5000000b006866a9b28eesm341103otl.18.2023.01.29.12.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 12:16:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 29 Jan 2023 12:16:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cormier <jcormier@criticallink.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: hwmon: adi,ltc2945: Add binding
Message-ID: <20230129201604.GA1583293@roeck-us.net>
References: <20230126-b4-ltc2945_shunt_resistor-v4-0-bb913470d8da@criticallink.com>
 <20230126-b4-ltc2945_shunt_resistor-v4-1-bb913470d8da@criticallink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126-b4-ltc2945_shunt_resistor-v4-1-bb913470d8da@criticallink.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 05:32:23PM -0500, Jonathan Cormier wrote:
> Create initial binding for the LTC2945 I2C power monitor.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>

Series applied, after merging patch 4/5 and 5/5 of the series
to avoid spurious 32-bit build failures, and after fixing a
continuation line alignment.

In the future, please run checkpatch --strict on your patches,
and please provide change logs.

Thanks,
Guenter
