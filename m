Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF656E866A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjDTA1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDTA1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:27:16 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2455FF0;
        Wed, 19 Apr 2023 17:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=D5cMFUbrPHYK0KNHQwDSw4HMAqqpSlMOS9Cbu0JzJBs=; b=wF70H4BjECjSPJkwnaqPSGz9Uh
        Mznf9iwG1xUo+CG8Of6YAi7X5IvINaPGZ9AVT5gykz7udPS1TSQzoHdUt7zWn3pZN+5j9EJiHgby/
        Y1Kh8azLf5Q07VFM50RezgmqcHc5j1zDg7aUg1mPIk3kZ0TeTzLWj/OOj55Y0jZFc81s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ppI8e-00AjqI-BI; Thu, 20 Apr 2023 02:27:04 +0200
Date:   Thu, 20 Apr 2023 02:27:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Martin Schiller <ms@dev.tdt.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] leds: trigger: netdev: use mutex instead of spinlocks
Message-ID: <45a1f1d2-8d9b-4bc2-ba16-9dafa517fd17@lunn.ch>
References: <20230419210743.3594-1-ansuelsmth@gmail.com>
 <20230419210743.3594-6-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419210743.3594-6-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 11:07:43PM +0200, Christian Marangi wrote:
> Some LEDs may require to sleep while doing some operation like setting
> brightness and other cleanup.
> 
> For this reason, using a spinlock will cause a sleep under spinlock
> warning.
> 
> It should be safe to convert this to a sleepable lock since:
> - sysfs read/write can sleep
> - netdev_trig_work is a work queue and can sleep
> - netdev _trig_notify can sleep
> 
> The spinlock was used when brightness didn't support sleeping, but this
> changed and now it supported with brightness_set_blocking().
> 
> Convert to mutex lock to permit sleeping using brightness_set_blocking().
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
