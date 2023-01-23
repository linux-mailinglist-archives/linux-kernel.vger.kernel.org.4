Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC56E6785E9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjAWTNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjAWTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:13:54 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44EFB59D9;
        Mon, 23 Jan 2023 11:13:52 -0800 (PST)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 7C9C57A0327;
        Mon, 23 Jan 2023 20:13:51 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] pata_parport: add driver (PARIDE replacement)
Date:   Mon, 23 Jan 2023 20:13:48 +0100
User-Agent: KMail/1.9.10
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121225314.32459-1-linux@zary.sk> <425b5646-23e2-e271-5ca6-0f3783d39a3b@opensource.wdc.com>
In-Reply-To: <425b5646-23e2-e271-5ca6-0f3783d39a3b@opensource.wdc.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202301232013.48779.linux@zary.sk>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2023 02:03:16 Damien Le Moal wrote:

[...]

> You are missing:
> 
> #ifndef LINUX_PATA_PARPORT_H
> #define LINUX_PATA_PARPORT_H
> 
> > +#include <linux/libata.h>
> > +
> > +#define PI_PCD	1	/* dummy for paride protocol modules */
> > +
> > +struct pi_adapter {
> > +	struct device dev;
> > +	struct pi_protocol *proto;	/* adapter protocol */
> > +	int port;			/* base address of parallel port */
> > +	int mode;			/* transfer mode in use */
> > +	int delay;			/* adapter delay setting */
> > +	int devtype;			/* dummy for paride protocol modules */
> > +	char *device;			/* dummy for paride protocol modules */
> > +	int unit;			/* unit number for chained adapters */
> > +	int saved_r0;			/* saved port state */
> > +	int saved_r2;			/* saved port state */
> > +	unsigned long private;		/* for protocol module */
> > +	struct pardevice *pardev;	/* pointer to pardevice */
> > +};
> > +
> > +typedef struct pi_adapter PIA;	/* for paride protocol modules */
> > +
> > +/* registers are addressed as (cont,regr)
> > + *	cont: 0 for command register file, 1 for control register(s)
> > + *	regr: 0-7 for register number.
> > + */
> > +
> > +/* macros and functions exported to the protocol modules */
> > +#define delay_p			(pi->delay ? udelay(pi->delay) : (void)0)
> > +#define out_p(offs, byte)	do { outb(byte, pi->port + offs); delay_p; } while (0)
> > +#define in_p(offs)		(delay_p, inb(pi->port + offs))
> 
> It would be way nicer to have these as inline functions.

This should go away (as well as the code below) so I'm not touching it now.

> > +
> > +#define w0(byte)		out_p(0, byte)
> > +#define r0()			in_p(0)
> > +#define w1(byte)		out_p(1, byte)
> > +#define r1()			in_p(1)
> > +#define w2(byte)		out_p(2, byte)
> > +#define r2()			in_p(2)
> > +#define w3(byte)		out_p(3, byte)
> > +#define w4(byte)		out_p(4, byte)
> > +#define r4()			in_p(4)
> > +#define w4w(data)		do { outw(data, pi->port + 4); delay_p; } while (0)
> > +#define w4l(data)		do { outl(data, pi->port + 4); delay_p; } while (0)
> > +#define r4w()			(delay_p, inw(pi->port + 4))
> > +#define r4l()			(delay_p, inl(pi->port + 4))
> > +
> > +static inline u16 pi_swab16(char *b, int k)
> > +{
> > +	union { u16 u; char t[2]; } r;
> > +
> > +	r.t[0] = b[2 * k + 1]; r.t[1] = b[2 * k];
> > +	return r.u;
> > +}
> > +
> > +static inline u32 pi_swab32(char *b, int k)
> > +{
> > +	union { u32 u; char f[4]; } r;
> > +
> > +	r.f[0] = b[4 * k + 1]; r.f[1] = b[4 * k];
> > +	r.f[2] = b[4 * k + 3]; r.f[3] = b[4 * k + 2];
> > +	return r.u;
> > +}

-- 
Ondrej Zary
