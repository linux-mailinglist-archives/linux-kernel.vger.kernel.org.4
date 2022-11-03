Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7202617C7C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiKCMZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKCMZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:25:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9A0A455;
        Thu,  3 Nov 2022 05:25:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p21so1746497plr.7;
        Thu, 03 Nov 2022 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoyesS99Fc4fhJQxB70DEhu+bNqWB5Z2Q4GxLzfZjGs=;
        b=Q1SxqeOy5yvsxRTe2bAwnCmnDEciefYeJVHpiPnlaE4F6A3oVUOjcxg/UDC5JyAc+x
         Qx+9hq0WDVmCDCVDrZbt5rc8JhJtp9+3L3hK6trXaDeNtKbE3Kc0iJ4ZXUya1tMfh4at
         f7fOEeB2j64UCPNfaaYY34uDtLdEnafNu4ptTI4cKTvHwQmzPl7HRaFKfTXvD8rzpBjx
         QhzgrWeErKhVa2XtzZ6fHrJPI6ylQJ64icdWFQC402PmbiuWk98lft8Vt3oJGW8Io04m
         P9ZZAb0XHIUbyaynfuYnCDfSEccXCxxSpXc22MgbY+qnQthzKGRt3CzA1Sl5OCo5eTfG
         CXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoyesS99Fc4fhJQxB70DEhu+bNqWB5Z2Q4GxLzfZjGs=;
        b=YIyzYUgOOELJ/WzW940lm8rey/Wame3m1GW/GAI5ZDC/8O2McUTPTmi9IvUBrk7xJ1
         rmdOWl63ogv5qmSzIO8mtScTimWDpzLb9TKwtYfHepBMPGQV/Kc1IXvxjRexNMbXRAJf
         Cd4jJFVw9wxxIn0p9z3oqAi1JMsrFk5gSlb5AmEXfpC74NjusK4WeXDGspqulsQ17xJ/
         iaRifaUV4hWIPnvL4m/6+puV5FTu+rAmL2t6OHJLfEWP4KIoGGa4YfdGmOsMKXh1wlZd
         ODVG6joWS8mKJrywZQcPoU5uhSHMNesS2M4Atq/JDz+HeQiFtFRlc5fgjivFBAGp8T6n
         V4wQ==
X-Gm-Message-State: ACrzQf2UUAy07DY4bHQz1/RlLcoiaWC276xJieRsU6E2Eui45JiWW0jV
        cFVm6ejuWHxyQEJ5nqg1gpY=
X-Google-Smtp-Source: AMsMyM5NJhLeXX3IAb1/d7cMSRIAnsxBzWsfPCni3KFWy5jutUunzq3rKvx/d8yjJn8MH/ZkLYFvDQ==
X-Received: by 2002:a17:90b:4a09:b0:213:9911:5f07 with SMTP id kk9-20020a17090b4a0900b0021399115f07mr31640342pjb.160.1667478308284;
        Thu, 03 Nov 2022 05:25:08 -0700 (PDT)
Received: from localhost.localdomain (2403-580a-80ed--90b3-8553.ip6.aussiebb.net. [2403:580a:80ed::90b3:8553])
        by smtp.gmail.com with ESMTPSA id d190-20020a6236c7000000b0056c3a0dc65fsm633526pfa.71.2022.11.03.05.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:25:07 -0700 (PDT)
From:   James Calligeros <jcalligeros99@gmail.com>
To:     viresh.kumar@linaro.org
Cc:     jcalligeros99@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, nm@ti.com, rafael@kernel.org,
        sboyd@kernel.org, vincent.guittot@linaro.org, vireshk@kernel.org
Subject: Re: [PATCH V2 5/5] OPP: decouple dt properties in opp_parse_supplies()
Date:   Thu,  3 Nov 2022 22:24:25 +1000
Message-Id: <3519763.iIbC2pHGDl@makoto>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <5acd93462bff6c108d65802fd39f6002dfadd1a0.1667473008.git.viresh.kumar@linaro.org>
References: <cover.1667473008.git.viresh.kumar@linaro.org> <5acd93462bff6c108d65802fd39f6002dfadd1a0.1667473008.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 3 November 2022 9:01:08 PM AEST Viresh Kumar wrote:

> @@ -674,7 +677,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
>  	bool triplet;
>  
>  	microvolt = opp_parse_microvolt(opp, dev, opp_table, &triplet);
> -	if (IS_ERR_OR_NULL(microvolt))
> +	if (IS_ERR(microvolt))
>  		return PTR_ERR(microvolt);
 
Erroring out here will still block EM registration on platforms without 
the opp-microvolt prop so we're back to square one, which means the 
patch does not do what the description says it does. It behaves
almost identically to the current code.

I assume this is an intentional choice given the comments in
opp_parse_microvolt(), so the commit message should drop 
references to fixing such platforms.

If this is a hard sticking point and opp_parse_supplies() must return
a regulator with opp-microvolt, then I am of the opinion that the parsing
of opp-microwatt should be detangled entirely from the regulator
infrastructure.

Otherwise for the whole series,

Tested-by: James Calligeros <jcalligeros99@gmail.com>

- James

