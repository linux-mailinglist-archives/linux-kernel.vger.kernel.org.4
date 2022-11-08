Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DAD6217C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiKHPNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiKHPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:13:25 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB7A52887
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667920385; bh=sejP4aBDdhMo3HG9Xhj2vvP0zlb9qbq1zHjDd4eRHUM=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=ZuiOdBdjtkEIP+oN7dr8IVxqYOpsonyeISX+DbXtTEo1QPmbjl5am5DM8za3qZ0YY
         hwaGCcfhBAUEM4DKUfgUUCHhTIDXJ6Iw9CUsAipf/cfzP5aMAKLYAaDEnmnAuYnxB4
         4crHcJX4yRfHt2doHIiidtWeZ+qN/DXubq635474=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  8 Nov 2022 16:13:05 +0100 (CET)
X-EA-Auth: OlqpyWd3qQcgdjOz9yJAVFrkj87A1WXK9JgBsKUSYg+jqfeXlddkMDsowDf2k8clG2dGPZ5qCVS6zAKNw6gfGH2vXDnrj/ry
Date:   Tue, 8 Nov 2022 20:42:59 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: staging/wlan-ng query: convert to flexible array member
Message-ID: <Y2px+zOGjkpGh6qC@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First, my apologies for the long email.
I am requesting guidance on how to approach resolving the zero element flexible
VLO struct implementation in this driver in file drivers/staging/waln-ng/hfa384x.f

The struct hfa384x_pdrec contains nested structs with zero element arrays.  These
zero element structs are part of a union 'data' inside the struct container. This
union 'data' is the last element of this container. Please see the code snip below:

<snip>

	1068 struct hfa384x_pdrec {
	   1         __le16 len;             /* in words */
	   2         __le16 code;
	   3         union pdr {
	   4                 struct hfa384x_pdr_pcb_partnum pcb_partnum;
	  11                 struct hfa384x_pdr_nicid nicid;
	  12                 struct hfa384x_pdr_refdac_measurements refdac_measurements;
	  13                 struct hfa384x_pdr_vgdac_measurements vgdac_measurements;
	  14                 struct hfa384x_pdr_level_comp_measurements level_compc_measurements;
	  15                 struct hfa384x_pdr_mac_address mac_address;
	  39         } data;
	  40 } __packed;

</snip>

The three structures in question are declared as follows in the same file:

<snip>
	962  struct hfa384x_pdr_refdac_measurements {
	   1         u16 value[0];
	   2 } __packed;
	   3
	   4 struct hfa384x_pdr_vgdac_measurements {
	   5         u16 value[0];
	   6 } __packed;
	   7
	   8 struct hfa384x_pdr_level_comp_measurements {
	   9         u16 value[0];
	  10 } __packed;
</snip>

As per the C99 specifications, the flexible array struct should have at least
one member other than the true flexible array member. So converting these from
[0] to [] is not feasible in the current form.

I did not find these struct variables being used for memory allocation in the
code directly. My find may be short since the implementation appears to get very
complex as I tried to get deeper.

Can you please suggest how should I approach correcting the zero element flex
array implementation here? Can these structs be removed if they are unused?

Thank you.
./drv



