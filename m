Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8426C5BE089
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiITIoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiITInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:43:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7A267;
        Tue, 20 Sep 2022 01:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663663389; x=1695199389;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NXtQOKSqmEjuG2E6ZCFhhcSyrJvV/xQNTl1GGhPictM=;
  b=IBWWhCP4e9q2C60o/xKWiG0dV8Mv7r6CWdKlU4slJY1mVBSdhDxAyXZn
   AGTKaK6dONKG89XnputlJVjTgKYOsEpvZ6dUVO11tnprlZa1NwaquD8Od
   tb1HZNW1XGWSQcrqVCjfPQhAALf0w4QQ+xSEIE/PNU6aDP2LqTlQ0z9QT
   AfJZV93cM/sB8i8kN92kEu1sdm5WrbMT9sshu5UJ50eApUf7LfegSCpSD
   tGl/+f+G1+qfn7juOUoZrOuILsVzqpRoILix7EPcVp3vqkyfswAPqTpV3
   qyINOSLGs6/rcOnynYF8nUSyzwk2Lqy3F1xCuT7h+ndy4E48w77nDCOwz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="300456126"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="300456126"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:43:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="652011156"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:43:06 -0700
Date:   Tue, 20 Sep 2022 11:43:04 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/10] tty: serial: introduce transmit helpers
In-Reply-To: <20220920052049.20507-9-jslaby@suse.cz>
Message-ID: <962593ae-e38-70ba-1e85-ee5e6b231856@linux.intel.com>
References: <20220920052049.20507-1-jslaby@suse.cz> <20220920052049.20507-9-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2112059611-1663663387=:1766"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2112059611-1663663387=:1766
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 20 Sep 2022, Jiri Slaby wrote:

> Many serial drivers do the same thing:
> * send x_char if set
> * keep sending from the xmit circular buffer until either
>   - the loop reaches the end of the xmit buffer
>   - TX is stopped
>   - HW fifo is full
> * check for pending characters and:
>   - wake up tty writers to fill for more data into xmit buffer
>   - stop TX if there is nothing in the xmit buffer
> 
> The only differences are:
> * how to write the character to the HW fifo
> * the check of the end condition:
>   - is the HW fifo full?
>   - is limit of the written characters reached?
> 
> So unify the above into two helpers:
> * uart_port_tx_limited() -- it performs the above taking the written
>   characters limit into account, and
> * uart_port_tx() -- the same as above, except it only checks the HW
>   readiness, not the characters limit.
> 
> The HW specific operations (as stated as "differences" above) are passed
> as arguments to the macros. They are:
> * tx_ready -- returns true if HW can accept more data.
> * put_char -- write a character to the device.
> * tx_done -- when the write loop is done, perform arbitrary action
>   before potential invocation of ops->stop_tx() happens.
> 
> Note that the above are macros. This means the code is generated in
> place and the above 3 arguments are "inlined". I.e. no added penalty by
> generating call instructions for every single character. Nor any
> indirect calls. (As in some previous versions of this patchset.)
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2112059611-1663663387=:1766--
