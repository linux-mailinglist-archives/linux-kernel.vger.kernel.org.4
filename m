Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731475B638E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiILWTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiILWTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:19:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8876F1FCC8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:18:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so4281722pjk.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=GZ0Dp6bNMavCz8G/Vh2kzpN1KgGgT7JTNvQgTmQAPlI=;
        b=Xj4Ka5yJAPeUxPPmQEVuECU48vRPrThJvunNyZAXnh3aURDS6/9cvsnGcIlrHrPoI8
         1DxlWMnd3NyIStmlBQPh7buLsBE0+J/CL2s9lhcIDiVvYsmolItMAsZrRnbtol2bLRYE
         aWug31ihhqBIkVbwOpwhayqG76YFy5UHb1AFTFm4OdsXS0MdtBAKJPn9+dNe3vwqwdAf
         3dxBmXGRPXhjZ7H91REGlGWdziagih7nIEfNrNoprlKydyoLMXvAkWlgL8f3zJMZESSQ
         cEuUollVy57b6Oh9jSdnayPiriu5FhxQYJplJ0XuEs4LONrMBP7aagwCU4OXPSXVmlZA
         I/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GZ0Dp6bNMavCz8G/Vh2kzpN1KgGgT7JTNvQgTmQAPlI=;
        b=1+48hAXOU8ZLRQK3yb+btNnMc2var5BOp4hWXAAMrfQvky5OnSFO49HnoJCVkPNxCZ
         Zt6WSNXmqkJvgnfpl1orj6JKkrJDjnUmC5qhpsBkwivL59wTBKtaDAXYCuDYSenpDJz9
         4QTh0Tqik0YWYBUfT7kkbKwd+/a2u41mPKNx0p4fLqBiHaduxaIPik0KXNeb57jKQnsX
         JMC99yAGw8c/Xat+4agsN568iIDJdZOzuIMuMtxGbwekYvmFfsV9FQ3/wcwFLj2OqElS
         q7Cae1sWmsTEIF8ZQfcneFdn2oBAYVyJbcNt1AVqtv+cGrZv9MCn6LWpieNVZw4vkfwV
         dw3g==
X-Gm-Message-State: ACgBeo05DZNjoujqQ/HSmCcsgnVzLXMz9l3XedfzzE4CTG5IxB5UFygj
        rHo6HCGW8VVcFPqfJeJZvYI=
X-Google-Smtp-Source: AA6agR5K4tR/87pHFmAbAuVZkP948XJNjqTQ08I2np9T61pNInwzJ4zew6hYxVpUotOpWNHqNdnsjQ==
X-Received: by 2002:a17:90a:e7ca:b0:202:c6c9:4750 with SMTP id kb10-20020a17090ae7ca00b00202c6c94750mr556951pjb.133.1663021099926;
        Mon, 12 Sep 2022 15:18:19 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b00177efb56475sm6655088plg.85.2022.09.12.15.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:18:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Sep 2022 12:18:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com
Subject: Re: [PATCH v3 6/8] sched/fair: Add sched group latency support
Message-ID: <Yx+wKhhk5niBZMNO@slm.duckdns.org>
References: <20220909130309.25458-1-vincent.guittot@linaro.org>
 <20220909130309.25458-7-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909130309.25458-7-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Sep 09, 2022 at 03:03:07PM +0200, Vincent Guittot wrote:
> +	{
> +		.name = "latency",
> +		.read_s64 = cpu_latency_read_s64,
> +		.write_s64 = cpu_latency_write_s64,
> +	},

You're still using the nice value here, right? If so, can you please use the
filename "latency.nice" so that it's consistent with "weight.nice"?

Thanks.

-- 
tejun
