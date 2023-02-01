Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33538686E98
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBATDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjBATDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:03:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C619C2005B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:03:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F940B82268
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15BDC4339B;
        Wed,  1 Feb 2023 19:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675278192;
        bh=cRvZPtCCADjg1w8znO75lNNtMiBjHAij0TBKOiOr2xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fm2wVYk/OIOGN4FVSou3pHWVSQsSRo8BW+TihJNvU9mppgeKIH3/V7D/rJZ0pbt3H
         9FwXbFf6GFVdHAsg3lDQfucpOIh1oZWKJ5jfUuEiWAoYVdlBZLWVXFh1v39QCup1Sd
         UlA9IkIs+NDE9JeEwbT7ftZVJd+QfbrKn87OxOAs=
Date:   Wed, 1 Feb 2023 20:03:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: bus: move lock_class_key into dynamic
 structure
Message-ID: <Y9q3bH9xxxWWCfWn@kroah.com>
References: <20230201083349.4038660-1-gregkh@linuxfoundation.org>
 <CAJZ5v0h5=HRRQ9oEHEgm362WtPFGYkfQeQLh_g1V7qF2OiFgUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h5=HRRQ9oEHEgm362WtPFGYkfQeQLh_g1V7qF2OiFgUg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 07:59:42PM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 1, 2023 at 9:33 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Move the lock_class_key structure out of struct bus_type and into the
> > dynamic structure we create already for all bus_types registered with
> > the kernel.  This saves on static space and removes one more writable
> > field in struct bus_type.
> >
> > In the future, the same field can be moved out of the struct class logic
> > because it shares this same private structure.
> >
> > Most everyone will never notice this change, as lockdep is not enabled
> > in real systems so no memory or logic changes are happening for them.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This looks reasonable to me, so
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks for the review.
