Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2417497B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGFIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGFIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:52:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0F71BC2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:52:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso366999f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688633553; x=1691225553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vt2Qqd3j+522zMhrl7U+jp/PfgQnzY1I/+V4Pc2okKI=;
        b=gZm8WHn0DlRhBuk1yvb+u8NhOtXLC2eyYj590Um4l6zP2gUFJoRTRhCCxfhrsZxJEC
         61Nda6GEDZ34YOCvQSUP/3fhE8lNxaRe7MmBdM4WWe5MUYe7ilr/VkA/nAn21J/XOvGI
         sTocvlQPYT1Ff77ADJvzPIG70vmUfqmODLwKwffhUY/Sz2k4Wdh2bYaHS0ippS8bxsDI
         9rqPiMVBxIVy7Ew6qNjpdjKK9nSFc2U1hXkoRbOIci/38C5s86UTElHoMASU5whdIMlD
         h+t340rIdu165BPGnkTxc0JdzA8fbJ40I1tlg6JjaW5k7RlRT/zKogcv/FkB/fWi4hUV
         8iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688633553; x=1691225553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt2Qqd3j+522zMhrl7U+jp/PfgQnzY1I/+V4Pc2okKI=;
        b=Zx+KFvE7k4Ehte5+CquCKd2rRflqYhCQThzBqu/AKkHIAdX4Ffumlm2P6KtxbrsfDQ
         /PLFj+ZuvX4TdX63MWXzsQYjkHpFWKae48yjtZN0En6kE1zcHfhMoI0ToQEFPsU3cvZU
         brV0cLlhbH3lrOU6DnfWYB9ErEwiLPOLgRMZLTuwK6dMwgiem8TOzDCSva7QzylC/PUm
         edd7ke6EKzxOQ1NQkdouaG5FUnJvyYwIM6zgOBmCNvaqFOvjQqPnko8ZAUl5dXGh60Oo
         fJ/5q/F+SBmrIgKu1VWVQBadL1QBvShTjkVZfhFxdIF7IEu+TzrITIXv49BQKqHQqpY/
         CA0g==
X-Gm-Message-State: ABy/qLYMOWAfdfJ64p650m1Yxnaq0AnaQ+LIWLF0RvFPA5xa8OKW/U7G
        XtF8cbH8B8cTGkn/bhK7qLvj9Q==
X-Google-Smtp-Source: APBJJlGlwWlCR0t3s9LI777OuttkuWUmBJZgariaOrRFfeRAwMXQ9nS3sAfbjMZfq0sn9nkXaKwlWA==
X-Received: by 2002:adf:fc0c:0:b0:313:f783:262b with SMTP id i12-20020adffc0c000000b00313f783262bmr976505wrr.26.1688633553461;
        Thu, 06 Jul 2023 01:52:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d5606000000b0031432c2fb95sm1267011wrv.88.2023.07.06.01.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:52:31 -0700 (PDT)
Date:   Thu, 6 Jul 2023 11:52:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGZpcm13?=
 =?utf-8?Q?are=3A_stratix10-svc?= =?utf-8?Q?=3A?= Fix an NULL vs IS_ERR() bug
 in svc_create_memory_pool()
Message-ID: <fe812000-c5bf-4510-a3a9-76684a59ecc9@kadam.mountain>
References: <20230704082706.1721-1-machel@vivo.com>
 <fe780326-2150-a3e6-e451-ea82be65e0cf@web.de>
 <daa12e00-1d01-45d0-89c8-03ff94fa3399@kadam.mountain>
 <SG2PR06MB3743AC289C8C124CA57C77DABD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR06MB3743AC289C8C124CA57C77DABD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 08:44:39AM +0000, 王明-软件底层技术部 wrote:
> Thank you Dan carpenter.
> This patch has been submitted for a long time, but I have not heard back from the maintainer, 
> and I am confused whether I need to send it again

You have to wait for at least two weeks before asking about a patch.

But the merge window is open now so everyone is busy.  Add another week
because of the merge window.

regards,
dan carpenter
