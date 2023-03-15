Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ECC6BBE03
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjCOUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCOUft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:35:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB8C567B5;
        Wed, 15 Mar 2023 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678912548; x=1710448548;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YTP0/6cwU8JktExo5ElC+GWJKWhyv6IQ+sWZM6ARXlY=;
  b=DzFNbQyGY3pxoSGRNHk0shqTDHpZZMaTLkKTLrw/c3RJZudxuAik6GZU
   X7x9EN7P5T8gtTlSK+pQlMkmxe+7Vt0ERcGitxUMOZYy8HmTmJ8hPmGYt
   8i8KLgogOR/PDlFZuY0Vmi4h1wl6FC8q2Ath9ieKgJm2rmG/j9ydQqlCF
   czvP4xHl1V5FRnvkdTwEMbzW++fN6CwbwtBGmoLIhVd/+1MMQz9rkHshG
   065+nuGsp09NRs+YtdXdlQC8DcVA9rJQhfoH2ImNontMq/NOzmb4UBHWY
   zp3kB/7YYgOFhKijdFdDNH0yTuakj0go0GMrQAncm52yK4u4F/xIpFgl8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321659247"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321659247"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 13:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="672869204"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672869204"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.18.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 13:35:47 -0700
Message-ID: <4aef4cd04a499c022c64c5e0276ce36f9ff3eacf.camel@linux.intel.com>
Subject: Re: [PATCH v2] Fix buffer overrun in HID-SENSOR name string
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Todd Brandt <todd.e.brandt@intel.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        jikos@kernel.org, p.jungkamp@gmx.net
Date:   Wed, 15 Mar 2023 13:35:42 -0700
In-Reply-To: <cdfe3d41-5ea4-c6a8-fbab-4920d08c6303@kernel.org>
References: <20230313220653.3996-1-todd.e.brandt@intel.com>
         <cdfe3d41-5ea4-c6a8-fbab-4920d08c6303@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-15 at 08:04 +0100, Krzysztof Kozlowski wrote:
> On 13/03/2023 23:06, Todd Brandt wrote:
> > On some platforms there are some platform devices created with
> > invalid names. For example: "HID-SENSOR-INT-020b?.39.auto" instead
> > of "HID-SENSOR-INT-020b.39.auto"
> >=20
> > This string include some invalid characters, hence it will fail to
> > properly load the driver which will handle this custom sensor. Also
> > it is a problem for some user space tools, which parse the device
> > names from ftrace and dmesg.
> >=20
> > This is because the string, real_usage, is not NULL terminated and
> > printed with %s to form device name.
> >=20
> > To address this, we initialize the real_usage string with 0s.
> >=20
> > Philipp Jungkamp created this fix, I'm simply submitting it. I've
> > verified it fixes bugzilla issue 217169
> >=20
> > Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> > Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
>=20
> SoB denotes that you reported this and tested. Otherwise shall we
> start
> adding Reported and Tested tags to all of our commits?
>=20
I just copied it from someone else's post on the mailing list, I
thought it was part of the standard lkml vernacular but I just looked
it up and it's explicitly forbidden in
Documentation/process/maintainer-top.rst line 385. So the answer is no.
I'll not use it again.

>=20
> Best regards,
> Krzysztof
>=20

