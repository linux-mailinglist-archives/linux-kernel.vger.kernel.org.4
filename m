Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D8963BB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiK2Hyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiK2Hy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:54:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4617E3FB83
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:54:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5BCB615B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9C1C433D6;
        Tue, 29 Nov 2022 07:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669708466;
        bh=7vBalyth42QY7Wd4sXJsLJfQcQQNSL1bq/tPn3eVsdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTMlAi9MfhgmUFVbuoFKrES+oaVwje+i/LLzM+Vp3DfDoJkDu2LHKztVxtDwXeC0y
         7nxC5MOI6rIk4cJFLY5lOxpqmk3YX8eTi2iQ0LxYjG5ZhaGTthjrEI+xZ5vMwqN8lv
         TMa41HvKITGaoJksDNa5bw2VZgqe1BXYEhef275k=
Date:   Tue, 29 Nov 2022 08:54:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Yang Yingliang <yangyingliang@huawei.com>, kraig@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] genirq/irqdesc: fix WARNING in irq_sysfs_del()
Message-ID: <Y4W6rzRZ/7llmsVx@kroah.com>
References: <20221128151612.1786122-1-yangyingliang@huawei.com>
 <Y4Tt2NIcPFeoss4s@kroah.com>
 <87zgcavrhm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgcavrhm.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 07:55:17PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 28 2022 at 18:20, Greg KH wrote:
> > On Mon, Nov 28, 2022 at 11:16:12PM +0800, Yang Yingliang wrote:
> >> @@ -292,6 +292,8 @@ static void irq_sysfs_add(int irq, struct irq_desc *desc)
> >>  		 */
> >>  		if (kobject_add(&desc->kobj, irq_kobj_base, "%d", irq))
> >>  			pr_warn("Failed to add kobject for irq %d\n", irq);
> >> +		else
> >> +			desc->sysfs_added = true;
> >
> > Wait, no.  Why are you just not properly failing and unwinding here?
> 
> There is an issue here.
> 
> sysfs is not yet available when the first interrupts are allocated. So
> we add the sysfs files late in the boot.
> 
> So what can we do if that fails? Unwind the boot process? :)
> 
> Sure we can fail after sysfs has been initialized, but that's
> inconsistent at best and we need some special treatment for the late add
> anyway.
> 
> I agree that this is not pretty, but the resulting choices are all but
> pretty.

Ah, ok, that makes more sense.  In this case, yes, the flag should be
fine to have.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
