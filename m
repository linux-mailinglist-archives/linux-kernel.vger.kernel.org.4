Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3146E3969
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjDPOka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjDPOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:40:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAF8BA;
        Sun, 16 Apr 2023 07:40:28 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7606d6b3294so166790139f.2;
        Sun, 16 Apr 2023 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681656027; x=1684248027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LawMsRg+LNSLNMdIWsQ2nWxjXRLwwEnsIdCSp/3ZHs=;
        b=jC4gDZMR2AbxTDW64UL/232UHrUuOCx9qy+TjS4hwsDB2AgTxduf4zqYShdTdIx0C5
         e//EVgCS2+jIb8cwapFbBBjOhR39TaeKIyibyeYxvn31HS5e0goyPlKSUZScxYCbo4uh
         j4rr0SfYLOiR05u6azpXXM/+EPWEUPeAuGQLnBbX9Zz83448kklxJyOnOe3lfSgMu8dD
         Rs7KbFrraUE2HVpgfwtw4Uup3DniAndkSIc0t+t/oulCgeXdLm79aoRY4gu/EC6Zt/fR
         lUa80fTqFYrGg24xMzdha4iurZ4R29F0Y0nmaM1z7TcOoUEilt7VDgsd8EWhiR9oosTC
         vtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681656027; x=1684248027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LawMsRg+LNSLNMdIWsQ2nWxjXRLwwEnsIdCSp/3ZHs=;
        b=IbgqTqDIZDRYVAJFGL3p8KBaVbp69Mgw/S1HRF6f1CbqnUCK0v0PDKi1UWJSf1f3lD
         N8D5YVGd9/aiHVbHHZ9mUwug0sccsEdYPQCLamhq8Aq9twsmbUEEWwm+L/4Rf19EN5br
         hzZO60WFpiQ9En48bVmEycZB4j6M3uBf58Rs+/oo+1EmCkGR94t5kByPP83vGpyclqdc
         0+Xh+O48R6G8DwxOQS8ghd+tuqh69F69YBifbLM4NVKP0vobiMWfJH8bB9jbT6e7AlrP
         mE18CjIX53Bi639tKE9wqD8yUz/fSQL90n671UA5y8K4ODPqeOoFFGtBQeIvj63uVy4g
         hCpA==
X-Gm-Message-State: AAQBX9dRsHEz9mrbuJeUQviOzg/AX3KQtwhfTcILnY80I0IL28bqShHz
        IxQqGYvrtQATAuM+HX9WVBfuAMbhRY0=
X-Google-Smtp-Source: AKy350a99cV798CIfsWH24+Jj+xGIxBop/lWi+SNrY7w+S3vtJarFvcdOXEPwGpkrvNL0TrPYytCdg==
X-Received: by 2002:a92:d24e:0:b0:32a:92a8:9e3 with SMTP id v14-20020a92d24e000000b0032a92a809e3mr7371742ilg.10.1681656027614;
        Sun, 16 Apr 2023 07:40:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n5-20020a056e02100500b0032b0b3eceddsm265111ilj.57.2023.04.16.07.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:40:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 07:40:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 1/5] dt-bindings: vendor-prefixes: Add prefix for acbel
Message-ID: <14e174be-90e9-4b33-9aa5-901337ed0b22@roeck-us.net>
References: <20230413132627.3444119-1-lakshmiy@us.ibm.com>
 <20230413132627.3444119-2-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413132627.3444119-2-lakshmiy@us.ibm.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 08:26:23AM -0500, Lakshmi Yadlapati wrote:
> Add a vendor prefix entry for acbel (https://www.acbel.com)
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter
