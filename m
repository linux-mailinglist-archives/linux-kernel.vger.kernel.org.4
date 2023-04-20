Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99B16E9293
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjDTL2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbjDTL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:27:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877A01FCA;
        Thu, 20 Apr 2023 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681990018; x=1713526018;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b+bn65UgUBu2kgw7EEFORx23vyge/baidPoo8gqQ1DI=;
  b=brZ03mSG+e7cUL541Wq7IQ7XrEr5FL6iYRuq3yAlFR3QqM4nBxSSqOhh
   G7ivAux6mVuZx9+wYImBUFEDjpUT8YyahtIKToVvlaJ9Oa4NQ56/4MJ7C
   ap0MZdgwgrBHRi4jmAp97gZaLtZZiyPgvu8Hsi7+PxJCnQyFRCS9aZGq8
   MlgWQNyPjljA3KVzDXRXWNDwt1IVGeM9bg55cH/O9Fz1LHU0hGgHlEp9K
   e+5QScl2WaRvr1zNtyes0bnIdnF85kd1ZDtva97We3tiA8qzzvclMxdiU
   0S4Mp9P5qa1JGI6vAWc+t/3LzsU3/8RTcZFSp2Z6ucJHRPY4lEtKLri2l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347569850"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="347569850"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 04:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021552325"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="1021552325"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO terminus) ([10.214.236.160])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 04:26:55 -0700
Message-ID: <7fe1b7ab73842ad8ee430cb171b6a59e3d6003bb.camel@intel.com>
Subject: Re: [PATCH v3] media: uvcvideo: Enable Intel RealSense metadata for
 devices.
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Date:   Thu, 20 Apr 2023 14:26:53 +0300
In-Reply-To: <ZEEEwt34bfmNEN99@valkosipuli.retiisi.eu>
References: <5587a4f1a0a7f3e2bd0ce886bb4ee3bcbf8f522a.camel@intel.com>
         <ZEEEwt34bfmNEN99@valkosipuli.retiisi.eu>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Thu, 2023-04-20 at 12:24 +0300, Sakari Ailus wrote:
> Hi Dmitry,
> =

> On Thu, Apr 20, 2023 at 12:06:55PM +0300, Dmitry Perchanov wrote:
> > Intel RealSense UVC Depth cameras produce metadata in a
> > vendor-specific format that is already supported by the uvcvideo driver.
> > Enable handling of this metadata for 7 additional RealSense devices.
> > =

> > Co-developed-by: Yu MENG <yu1.meng@intel.com>
> > Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> =

> Thanks for the update.
> =

> Is the D4XX format on these devices the same that's documented in
> Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst ? I.e. there a=
re
> no additional fields or differences, and the version of the format is the
> same?
We verified the document and found it generally correct.
Although, we expanded number of fields and I can update this document.
> =

> The format documentation doesn't say which version number even the current
> devices use (just refers to "xxx").
The document compatible with all D4xx/D5xx devices so far.
We dropped all obsolete incompatible cameras from support.
> =


Should I submit another patch with extended structures?

Regards,
Dmitry P.

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

