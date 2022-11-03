Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C6E61828E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiKCPXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiKCPXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:23:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1181A395;
        Thu,  3 Nov 2022 08:23:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so5503598pjc.3;
        Thu, 03 Nov 2022 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSr+j5NVKiaQKfyexBjniTj+hsGjZmECfoeuhtqx5oY=;
        b=nl4hwAxgDCnkbT375+YvDFPmdZC3EW9i3B3Jg+zGv4ZoeuK62Hh/mB12NqYbf8eEdm
         sp/ZzZNFUfNvOvfY4XkHngC/Hbx8vbax8DZG43MXeB2Ueo9CULssj+KMJ1eXrGN7w0EZ
         URG+n8Rw8YzN4f2hqbk2bg0Vj2J8TWcNw59Aw1LDU8p/DvScQExJv35AXd3u31w8HRow
         zaXC3oK1DRUc6wfQ9W9Gdnkr6xH6HtR52g5lKsgMtedJZ2SFNDeN3iZb0DT9vaqkl+Tp
         Oq5e3YCMw4TikRBCR5lT83eDrocswsyYA49q8X0nEzGMdLwwEqf3SvbTd0moaql5MgCZ
         wU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSr+j5NVKiaQKfyexBjniTj+hsGjZmECfoeuhtqx5oY=;
        b=URyDnNf0CsCH47v7ltXOBeFNweZYdsxD+S/40dvTuFYG6mPGDFV2Qd45yDQGh0DjtR
         FN/1N9LcZZbkGx5hnOppG2owmcOwh5rsx+mA1FSQru1tPS4vnd2hK2frlVzohuCcq9Hf
         8fPY0IVG5UV2VIRcg0a013C/xbQXWb9xYQTSRJ/4ncFVeav4h6PDlSBbLiqgmcpcuKLn
         EUpR1MWtuuAoOF7CYu69U09KrlneD2yOiho82PRqF2VjyVG5qgaL6JdlVdEq/BbYAnu1
         ld6NsPW7lDY1Lr+RgZR0jBdF71f6asA+diBcaQoHfKbrCXZElCMZbsZ3D62s1y3emjzH
         Qlcg==
X-Gm-Message-State: ACrzQf1pDKKwNm24voqK1G6T2MBoqGxy9iu9YHbgcZhYHcKoJRrWeVUB
        Zlli5QMFtVOKLnfzeUZjYsU=
X-Google-Smtp-Source: AMsMyM5I+SJHyEfsA9JyQvfO3UG5gWSJHG5UY+Z7kQeoQVxrmr9aFErvU7YiNHQuhbutt6gOGAxS8A==
X-Received: by 2002:a17:902:da8a:b0:187:3d6:4c60 with SMTP id j10-20020a170902da8a00b0018703d64c60mr30669393plx.117.1667489010643;
        Thu, 03 Nov 2022 08:23:30 -0700 (PDT)
Received: from makoto.localnet (2403-580a-80ed--ccac-899b.ip6.aussiebb.net. [2403:580a:80ed::ccac:899b])
        by smtp.gmail.com with ESMTPSA id p28-20020aa79e9c000000b00562f6df42f1sm856729pfq.152.2022.11.03.08.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:23:30 -0700 (PDT)
From:   James Calligeros <jcalligeros99@gmail.com>
To:     James Calligeros <jcalligeros99@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com,
        rafael@kernel.org, sboyd@kernel.org, vincent.guittot@linaro.org,
        vireshk@kernel.org
Subject: Re: [PATCH V2 5/5] OPP: decouple dt properties in opp_parse_supplies()
Date:   Fri, 04 Nov 2022 01:23:23 +1000
Message-ID: <2379445.NG923GbCHz@makoto>
In-Reply-To: <20221103131051.2ivkhibbsdarbewt@vireshk-i7>
References: <cover.1667473008.git.viresh.kumar@linaro.org> <3519763.iIbC2pHGDl@makoto> <20221103131051.2ivkhibbsdarbewt@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 3 November 2022 11:10:51 PM AEST Viresh Kumar wrote:
> On 03-11-22, 22:24, James Calligeros wrote:
> > On Thursday, 3 November 2022 9:01:08 PM AEST Viresh Kumar wrote:
> > 
> > > @@ -674,7 +677,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
> > >  	bool triplet;
> > >  
> > >  	microvolt = opp_parse_microvolt(opp, dev, opp_table, &triplet);
> > > -	if (IS_ERR_OR_NULL(microvolt))
> > > +	if (IS_ERR(microvolt))
> > >  		return PTR_ERR(microvolt);
> >  
> > Erroring out here will still block EM registration on platforms without 
> > the opp-microvolt prop so we're back to square one, which means the 
> > patch does not do what the description says it does. It behaves
> > almost identically to the current code.
> 
> I am confused.
> 
> With the current code, the following will work:
> - all three available
> - microvolt available and nothing else.
> - only microamp available
> - only microwatt available
> - both microamp and microwatt available but no microvolt
> - and other combinations
> 
> Isn't this all we want ?

You're right, I misinterpreted an error. Details as below.

> What did you test exactly ? As I thought you will be testing the only microwatt
> case here and you say it won't work.
> 
> Sorry, I just got a little bit confused :(
> 

I did test on the Apple machine with only opp-microwatt, but I misinterpreted
the error. We end up here upon parsing the second OPP:

>if (list_empty(&opp_table->opp_list) &&
>    opp_table->regulator_count > 0) {
>	dev_err(dev, "%s: opp-microvolt missing although OPP managing regulators\n",
>		__func__);
>	return ERR_PTR(-EINVAL);
>}

When this path is removed, things work as expected. Could it be that opp_list has
not been updated by the time we're parsing the next OPP? Seems unlikely, but
at the same time if we're ending up taking this branch then there's not much else
that could have gone wrong.

- James


