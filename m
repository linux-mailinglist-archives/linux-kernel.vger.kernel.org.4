Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2810172BF58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjFLKlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjFLKlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:41:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ACC319CD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47ABF615B9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF23C433EF;
        Mon, 12 Jun 2023 10:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565528;
        bh=jkLBoeKvgVSf1iEiYP2KB3CxUSh6MqVHrDpEPu8ZLL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kaMUAHHvXf1LUbuyW7bPq0DQ6R26GMRMLqJirt4UYlK5BG7G8cVzlJhiVrWdKn1K8
         W8UOcwqG+S8RGcsnPd33yA8RkvPRfjUQDX8Avy3pYY7l+JykiH1dCGPVRFu4eTdqAn
         alsJCpZoTItJIHh87aWEuto1DNVz1EfTbrq0Lu60=
Date:   Mon, 12 Jun 2023 12:25:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan McDowell <noodles@meta.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Kay Sievers <kay.sievers@vrfy.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: dmi: Don't restrict access to serial number /
 UUID
Message-ID: <2023061252-tapering-shrubs-4dd7@gregkh>
References: <ZIbslWZev/Ayoug5@noodles-fedora.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIbslWZev/Ayoug5@noodles-fedora.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:59:50AM +0000, Jonathan McDowell wrote:
> The /sys/devices/virtual/dmi/id/*_serial + product_uuid files are
> currently only readable by root. There's no clear rationale for this;
> Windows + OS X both allow regular users to access the information, so
> there appears to be no expectation on the manufacturer side that it
> should be kept secret.
> 
> Having the information easily available helps with automated tools that
> collect system information for the purposes of fault diagnosis/tracking
> without requiring the tools have root access.
> 
> (I've tried to look for context on the initial patch submission about
> why these were root-only but didn't find any; hopefully Lennart or Kay
> can provide details if I'm missing something.)

I think it was just generic "let's not expose anything that might be a
secret", but if Windows exposes all of this to any user, then vendors
are used to it, so it's not a big deal.

thanks,

greg k-h
