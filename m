Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE367591B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjATPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjATPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:51:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552F59742
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674229907; x=1705765907;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gYG8bbRbt/rhKlaJNI3iosDqiCy4zA84p3RRJ32SU9w=;
  b=biA9YJbwlK/ZyihFA4QUahiDphJ9RJ8roK6cW3CjZ/SZEC7zp1Hxc7+5
   3664eiCOotZylo/fek3DcRAwvw+5UbnFusSAY7NE42d/rB7xr/j/BdtfM
   0yZYSXpzv4qaDxtMJGxAPO/nfMiAsR7AXgkmWrtTo/3hJ/UA0+9BZQ87Y
   EXtAmp2x7xFog0ILZe6J59sSWMp2zTbMRJqY6L79pHFRCtKuO2dbQWhCE
   505bO2KQYGQxAjQp4mSNhZgkXtUv3Xrxsng6svU/EghYSBgI7zdDJV0tk
   gHvKgsQqcDReVbXPnFE126elwxMh0pqHJaztVzaXj+idlFI3FHhSb2wtn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="309181132"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="309181132"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 07:51:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="638190229"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="638190229"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 07:51:43 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 1/6] virtio console: Harden multiport against invalid
 host input
In-Reply-To: <20230120080130-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
 <20230120080130-mutt-send-email-mst@kernel.org>
Date:   Fri, 20 Jan 2023 17:51:42 +0200
Message-ID: <874jslqk4x.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Weird.  Don't we already check for that?
>
>         /* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
>         if (!is_rproc_serial(vdev) &&
>             virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
>                                  struct virtio_console_config, max_nr_ports,
>                                  &portdev->max_nr_ports) == 0) {
>                 if (portdev->max_nr_ports == 0 ||
>                     portdev->max_nr_ports > VIRTCONS_MAX_PORTS) {
>                         dev_err(&vdev->dev,
>                                 "Invalidate max_nr_ports %d",
>                                 portdev->max_nr_ports);
>                         err = -EINVAL;
>                         goto free;
>                 }
>                 multiport = true;
>         }

Yes, I missed this earlier. I'll drop this patch.

Thanks,
--
Alex
