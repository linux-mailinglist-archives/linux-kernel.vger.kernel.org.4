Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A5F63FBDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiLAXWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiLAXVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:21:55 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317A0C9365
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669936915; x=1701472915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZ7J5U8J85lANK+HEQrux7shSC2sB/ALt6HujdjDQmY=;
  b=CTL+GCU0DZtmxArXCCFVe31KskcQxUlmV8j67pBtUpfFzJ42Ej+TtR6W
   9OCFVJFhwr7V8To8WEeO2Sa7o3HAb2QIlB0CXOamN3kjoOOkwgbxaAxIE
   X3oE/UMHez6FYo2egAvmGE1OEDEtTgwX5NaVLGSpAfF30DTkR/j/8GL0X
   sv0GzCNzUS7OMA60Jtlzd7onIm0v1TFTBgeevvogF0vsJQ7WfC9j3RgUh
   KgBVjwzAb832hgjRizmXwsmxhISUZseNxq/8COSqsRYhHfyLtAvT84+zb
   EjnbPTGUisrEcEterM4jUjuXfExIGP/B0DaeKoA7pHRQrDjeLT6qM6ZKO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342755519"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="342755519"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 15:21:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="733597678"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="733597678"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 15:21:52 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 3C70320363;
        Fri,  2 Dec 2022 01:21:50 +0200 (EET)
Date:   Thu, 1 Dec 2022 23:21:50 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y4k3DrPW1eG9WB7r@paasikivi.fi.intel.com>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Dec 01, 2022 at 08:30:54PM +0100, Greg Kroah-Hartman wrote:
> container_of does not preserve the const-ness of a pointer that is
> passed into it, which can cause C code that passes in a const pointer to
> get a pointer back that is not const and then scribble all over the data
> in it.  To prevent this, container_of_const() will preserve the const
> status of the pointer passed into it using the newly available _Generic()
> method.

"_const" in the name suggests that the macro would always take a const
argument. Could this be called e.g. container_of_safe() (for type-safe, but
full type_safe would be a bit long)?

-- 
Kind regards,

Sakari Ailus
