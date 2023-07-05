Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9283F747B71
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 04:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGECPw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 22:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGECPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 22:15:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8664510E2;
        Tue,  4 Jul 2023 19:15:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qwjrl3xPlz6J7Ml;
        Wed,  5 Jul 2023 10:13:59 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 5 Jul
 2023 03:15:41 +0100
Date:   Wed, 5 Jul 2023 10:15:37 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Yangtao Li <frank.li@vivo.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <miquel.raynal@bootlin.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <rui.zhang@intel.com>, <mmayer@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <florian.fainelli@broadcom.com>, <tglx@linutronix.de>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <bchihi@baylibre.com>,
        <wenst@chromium.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/5] genirq/devres: Add
 devm_request_threaded_irq_emsg()
Message-ID: <20230705101537.000059d2@Huawei.com>
In-Reply-To: <20230704141954.fcmol2yswkpbnpaw@pengutronix.de>
References: <20230703090455.62101-1-frank.li@vivo.com>
        <20230703090455.62101-2-frank.li@vivo.com>
        <f4873823-fd7e-c6dd-fbc0-eac4a9be52b1@kernel.org>
        <20230703174347.4m6hcmify4jwsozv@pengutronix.de>
        <11052797-b006-11bb-e4eb-987ddd568b24@kernel.org>
        <20805fef-d6aa-91d8-999e-04b1d6b7a37a@vivo.com>
        <20230704141954.fcmol2yswkpbnpaw@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 16:19:54 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
> 
> On Tue, Jul 04, 2023 at 05:06:12PM +0800, Yangtao Li wrote:
> > On 2023/7/4 16:48, Krzysztof Kozlowski wrote:
> >   
> > > [你通常不会收到来自 krzk@kernel.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
> > > 
> > > On 03/07/2023 19:43, Uwe Kleine-König wrote:  
> > > > Hello Krzysztof,
> > > > 
> > > > On Mon, Jul 03, 2023 at 02:31:59PM +0200, Krzysztof Kozlowski wrote:  
> > > > > On 03/07/2023 11:04, Yangtao Li wrote:  
> > > > > > There are more than 700 calls to the devm_request_threaded_irq method.
> > > > > > Most drivers only request one interrupt resource, and these error
> > > > > > messages are basically the same. If error messages are printed
> > > > > > everywhere, more than 1000 lines of code can be saved by removing the
> > > > > > msg in the driver.  
> > > > > 
> > > > > ...
> > > > >   
> > > > > > +int devm_request_threaded_irq_emsg(struct device *dev, unsigned int irq,
> > > > > > +                              irq_handler_t handler, irq_handler_t thread_fn,
> > > > > > +                              unsigned long irqflags, const char *devname,
> > > > > > +                              void *dev_id, const char *emsg)
> > > > > > +{
> > > > > > +   int rc;
> > > > > > +
> > > > > > +   rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
> > > > > > +                                  devname, dev_id);
> > > > > > +   if (rc && rc != -EPROBE_DEFER) {
> > > > > > +           dev_err(dev, "Failed to request %sinterrupt %u %s %s: %pe\n",
> > > > > > +                   thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
> > > > > > +                   emsg ? : "", ERR_PTR(rc));  
> > > > > It is open-coding dev_err_probe(). Just use dev_err_probe instead.  
> > > > dev_err_probe is supposed to be only called in probe functions, while
> > > > devm_request_threaded_irq might be called in other contexts (e.g. when a
> > > > device is opened). That's why I asked to not use dev_err_probe() in v2  
> > > True, but then all the callers of this function will forget to set
> > > deferred probe reason.  
> 
> That's another reason for letting the driver issue the error message and
> not the request_irq function.
>  
> > So let's use dev_err_probe?
> > 
> > BTW, any suggestions for names here, keep using
> > devm_request_threaded_irq_emsg or change to a new name?  
> 
> I would have called it devm_request_threaded_irq_verbose() which I
> consider easier to understand. But maybe  is just my (green)
> bikeshed.

If going to use dev_err_probe() internally maybe can just use
devm_request_threaded_irq_probe() thus reflecting that and making
it different to the devm_request_threaded_irq()?

I'm not sure we need to call out the fact it prints an error message in
the naming.  Maybe the fact it should probably only be used in probe()
is the more relevant information?

Bikesheds should all be red!

Jonathan

> 
> Best regards
> Uwe
> 

