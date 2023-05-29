Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A8071511F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 23:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjE2VvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 17:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2VvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 17:51:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1538CF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 14:51:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685397062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbB5GEW6N6XR6fDTgOAi2+yyovZbSHzUMyqfv0TZelw=;
        b=QLZyIa4hi4aYScN+5gbkkMeWXHulYrevLiSZIgZ1d0Or3rkqCX0JZGVkgxEXIP4XIFcp4n
        mtsolMkxLg4hAEIEjQSKlYOwgNo6rlJK6CerC7oYUWyvUPyrbQ1pvfM/4bAKa11/GOApA9
        dy6TivB7HHdcAkrJkPIgd0GG3jol7GivzAKCNBRXKmX7TJwG08xc8qL3tcWCa6MaB7U6yo
        SFUe2QC341pYnLxSdJPdq3Gb2Jul8Y0yxcR74jFcLuIp2CBvjk26SD1yy1kPC4pl8ORCmt
        44FN3KKZAoGfVhT2ZL3qJRKxpctyvXS73Wl9VX5ItPJxUhKAOWaTrKWrS2Mz0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685397062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbB5GEW6N6XR6fDTgOAi2+yyovZbSHzUMyqfv0TZelw=;
        b=J4XcwjFOs6lSrL8jHe19t6U8p/T2Lg4j6XLMa2UTTUUvMB+V4qfiB7gc6dkErdKt0xsDJj
        4UwvOKWgCx7tpVAA==
To:     "Liao, Chang" <liaochang1@huawei.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Vikram Sethi <vsethi@nvidia.com>,
        Jason Sequeira <jsequeira@nvidia.com>
Subject: Re: [PATCH v5 1/3] genirq: Use hlist for managing resend handlers
In-Reply-To: <6dc6642a-1e7c-f111-1fa2-be54826ecef6@huawei.com>
References: <20230519134902.1495562-1-sdonthineni@nvidia.com>
 <20230519134902.1495562-2-sdonthineni@nvidia.com>
 <6dc6642a-1e7c-f111-1fa2-be54826ecef6@huawei.com>
Date:   Mon, 29 May 2023 23:51:02 +0200
Message-ID: <871qiylsc9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29 2023 at 15:57, Chang Liao wrote:
> =E5=9C=A8 2023/5/19 21:49, Shanker Donthineni =E5=86=99=E9=81=93:
>> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
>> index 844a8e30e6de..d9451d456a73 100644
>> --- a/include/linux/irqdesc.h
>> +++ b/include/linux/irqdesc.h
>> @@ -102,6 +102,9 @@ struct irq_desc {
>>  	int			parent_irq;
>>  	struct module		*owner;
>>  	const char		*name;
>> +#ifdef CONFIG_HARDIRQS_SW_RESEND
>> +	struct hlist_node	resend_node;
>> +#endif
>>  } ____cacheline_internodealigned_in_smp;
>
> Although there is no documented rule that limits the change of the KABI
> struct irq_desc, it is still better to keep the irq_desc definition
> stable.

Please read and understand:

       Documentation/process/stable-api-nonsense.rst

If you want KABI, then that's  _YOUR_ problem, period.

>> -/* Bitmap to handle software resend of interrupts: */
>> -static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
>> +/* hlist_head to handle software resend of interrupts: */
>> +static HLIST_HEAD(irq_resend_list);
>> +static DEFINE_RAW_SPINLOCK(irq_resend_lock);
>
> What is the benefit of using hlist here? If you want to enjoy the
> low latency of querying elements by key, you must define a hlist table
> with a reasonable number of buckets. Otherwise, I don't think the time
> complexity of hlist is better than a regular double-linked list,
> right?

What's complex about hlist in this case? Please explain.

Thanks,

        tglx
