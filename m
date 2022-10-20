Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5790260546A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 02:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiJTAPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 20:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJTAPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 20:15:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D35FAA43
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 17:15:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so1180923wmr.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 17:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pxI8kiw4rBDyzprun94lI3J+VU67DIHr00ooaxAPBxU=;
        b=VocGDT8YXXfmXMw5V24L7ALUOsZLW0qRtKHECWV8sWob9aM87OHJcZw+0qVD67v2r6
         RMPVV3pzEkmSJOXP6OylxCeMB21btV30UelZXnHrC1BkNP6JoJ8ptPGlZ+KbhBNgviUv
         tAS07O5TJKQC3H83wD2m+Igd2+serrJIJHnl7UM2XwOf29mCSAnjlM/jIXFkJxME6EOs
         9LgT7HxZnN5e7SPtCEmxjK4sWfu79FCTS5WfieZLsGObD54/pUclh3mkYDsL2rtBo6oy
         o2ci2FAwGvepobVdkBYdXWxNX35zoKTHcpKoOA6HZ48q1j2ZZiStPPJWL2LOfKBFJW7r
         2zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxI8kiw4rBDyzprun94lI3J+VU67DIHr00ooaxAPBxU=;
        b=AiiFNHZ8zNQ2TndXnwHNdWT1jiFAZALs3zmDX+jx+dRQiXEMeCxIT7lDd1mep8Ydie
         iQzxLjYDeOB1ZlrXxet+Ch+quNkT1m581XzkoajRoi5TSt85kVyqSWHY2vZwsIK9Y2Rw
         BY9pGGIT66y4b7q4iifM6Bcx1xV8GEnRx5uh70mbKmpxGiMHQbnnLJNQJxkUG8K//LDZ
         GTnjRR09wzbdjy34BNA8Lc4Gc/oHlCAgTi6MIACohoeGmxeCS3UvCfF3mT2EcCtp4Ny3
         taVPJ2SmM1Cg2n5ixt1WhAise1qAtyRhAzQzSZ/wTXvIeye6qHBZV/086dkiXfanN8PW
         VgnQ==
X-Gm-Message-State: ACrzQf1eNh0I6oFXwbPKPiYObYh3ycUTitSuMmY4zOvgYh3kzvBULb18
        tt1K0vabUvsde6txZggvthcgUA==
X-Google-Smtp-Source: AMsMyM47optp+N0c5MrnanAte8PnrF/flGeHMCD3RaXGV80e4K6dIAfP7crRZPGDXYP8tKn3DMjtyQ==
X-Received: by 2002:a05:600c:5252:b0:3c6:f478:96db with SMTP id fc18-20020a05600c525200b003c6f47896dbmr7606031wmb.116.1666224904109;
        Wed, 19 Oct 2022 17:15:04 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4492000000b0022f864164edsm15009276wrq.6.2022.10.19.17.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 17:15:03 -0700 (PDT)
Date:   Thu, 20 Oct 2022 01:15:01 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     John Stultz <jstultz@google.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Connor O'Brien <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [PATCH RFC v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Message-ID: <20221020001501.7qbqd5r4gvw3enjs@airbuntu>
References: <20221003232033.3404802-1-jstultz@google.com>
 <20221003232033.3404802-3-jstultz@google.com>
 <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
 <Y0+/SAWUNRnhIW9b@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCpQuQn_84yqErF2noAYDwdwNJQF-pr4JKVp1eZzH=+f9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANDhNCpQuQn_84yqErF2noAYDwdwNJQF-pr4JKVp1eZzH=+f9w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 15:09, John Stultz wrote:

> I fret there are some edge cases where on the target cpu softirqs
> might be pending but ksoftirqd isn't running yet maybe due to a
> lowish-prio rt task - such that the cpu could still be considered a
> good target. But this seems a bit of a stretch.

Could using ksoftirqd_running() instead help with robustness here?


Cheers

--
Qais Yousef
