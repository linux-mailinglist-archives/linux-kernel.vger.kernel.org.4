Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32B5F769F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJGKFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJGKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:05:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BD37F243;
        Fri,  7 Oct 2022 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665137109; x=1696673109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qQ1zrUjHcG+48NjTzwE6c3iRSqpwNICl7g4gQRyV8HQ=;
  b=K9peTyuNlHXPRXaLsl9qJo/cNKjB6IeY5fv2k59VTbLfn1VeoRDgXhxo
   KdlLGKAN+KWp44R7YCyUjf2CMatwSPuZPkMngS5eOisQwqJa4lvBUgFIa
   AVdIxuWtJUVomDF5zQgslnydl9oz5GjqowPDJ1h1e/HD/uxQagMhcbD8M
   hHBgyv3CWxGjJ1rLXsYANRpw70xSO8AaieMu7xRG13gFB4nPQfSKCFb+w
   0BieczLoyAFUSbr2ig2i9UEX7S4rbFqC8DNb08M+ZNiyXIzolht4QJe9c
   s5NQ2KRWRJydZNLsPwClgwnKJXqPyJ3PmJNTcM+8NxpnTWgxa1bhjo5CS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="283419553"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="283419553"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 03:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="767528763"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="767528763"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 07 Oct 2022 03:04:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 07 Oct 2022 13:04:51 +0300
Date:   Fri, 7 Oct 2022 13:04:51 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bastian Rieck <bastian@rieck.me>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        grzegorz.alibozek@gmail.com, andrew.co@free.fr, meven29@gmail.com,
        pchernik@gmail.com, jorge.cep.mart@gmail.com,
        danielmorgan@disroot.org, bernie@codewiz.org,
        saipavanchitta1998@gmail.com, rubin@starset.net,
        maniette@gmail.com, nate@kde.org
Subject: Re: [RFC PATCH 0/2] usb: typec: ucsi: Check connection on resume
Message-ID: <Yz/5w5faKmnJNPut@kuha.fi.intel.com>
References: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
 <YxrbtWDR7XI4s+Q+@kuha.fi.intel.com>
 <YyRUF5cFGpe2xf+m@kuha.fi.intel.com>
 <11781567.uqkIggiGGz@nimue>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11781567.uqkIggiGGz@nimue>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 12:00:16PM +0200, Bastian Rieck wrote:
> Dear Heikki, dear all,
> 
> I am still unable to reproduce the previous error messages I 
> mentioned. In the meantime, the UCSI issues disappeared with 5.19.9 
> for me (!). I think this is related to a revert by Takashi Iwai  [1] 
> in 5.19.8.
> 
> Given these data, would it be useful to test your patch against 
> 5.19.9 or a more recent version?

No need. I'm just about to resend these.

thanks,

-- 
heikki
