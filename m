Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB4D697B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjBOMNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjBOMNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:13:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D058D9745;
        Wed, 15 Feb 2023 04:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676463231; x=1707999231;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9/zg0/vaCqM8j5PpKGCD4TITFAwPqgndyDBOtOlHupk=;
  b=jXX0hzkpK426AKg+t10Gn23NRPhlwWbOfuinDOUWZH4FbBJa4fOgyTW1
   4fdH2N83fgzAiCYmGMWMayadWADJr3Oq9OjO4f+HErix0Qu2/16E9P/Uy
   FEEyznJZTH8mcsWUPtQpiMJNmiwYe8JiSP8oWlfI0WPrS/Fm1nUnsaVDl
   aYznYQ4ZDT5kHG8Qx69CfezhmmJHlH3YksXqOhatH/C7eb8nb43o3fCfT
   mCLESF4nkqxPKOfK5EgG2Z55q3s1SQlxv6xFyU/s7gFyYmRRxv3UmUqRu
   bCKwuLwrlQXecP1QE2LUZJ+us6wysm8yxhUlbBvgcMcLysR69q89BwCOx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319448067"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319448067"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 04:13:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="702011968"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="702011968"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.139]) ([10.238.232.139])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2023 04:13:47 -0800
Subject: Re: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wentong Wu <wentong.wu@intel.com>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        linux-media@vger.kernel.org, srinivas.pandruvada@intel.com,
        pierre-louis.bossart@linux.intel.com, zhifeng.wang@intel.com,
        xiang.ye@intel.com, tian.shu.qiu@intel.com, bingbu.cao@intel.com,
        linux-kernel@vger.kernel.org
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y+ypKYI4c6fHL4Eu@pendragon.ideasonboard.com>
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <00c5c16e-c94e-a328-06d9-5f09ad35258d@linux.intel.com>
Date:   Wed, 15 Feb 2023 20:09:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Y+ypKYI4c6fHL4Eu@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Wentong,

On 2/15/23 5:43 PM, Laurent Pinchart wrote:
> Hello Wentong,
> 
> On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
>> Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls", is a
>> companion chip designed to provide secure and low power vision capability
>> to IA platforms. IVSC is available in existing commercial platforms from
>> multiple OEMs.
>>
>> The primary use case of IVSC is to bring in context awareness. IVSC
>> interfaces directly with the platform main camera sensor via a CSI-2 link
>> and processes the image data with the embedded AI engine. The detected
>> events are sent over I2C to ISH (Intel Sensor Hub) for additional data
>> fusion from multiple sensors. The fusion results are used to implement
>> advanced use cases like:
>>  - Face detection to unlock screen
>>  - Detect user presence to manage backlight setting or waking up system
> 
> Do you have plan to support these features in the ivsc driver in the
> future ?
> 
>> Since the Image Processing Unit(IPU) used on the host processor needs to
>> configure the CSI-2 link in normal camera usages, the CSI-2 link and
>> camera sensor can only be used in mutually-exclusive ways by host IPU and
>> IVSC. By default the IVSC owns the CSI-2 link and camera sensor. The IPU
>> driver can take ownership of the CSI-2 link and camera sensor using
>> interfaces provided by this IVSC driver.
>>
>> Switching ownership requires an interface with two different hardware
>> modules inside IVSC. The software interface to these modules is via Intel
>> MEI (The Intel Management Engine) commands. These two hardware modules
>> have two different MEI UUIDs to enumerate. These hardware modules are:
>>  - ACE (Algorithm Context Engine): This module is for algorithm computing
>> when IVSC owns camera sensor. Also ACE module controls camera sensor's
>> ownership. This hardware module is used to set ownership of camera sensor.
>>  - CSI (Camera Serial Interface): This module is used to route camera
>> sensor data either to IVSC or to host for IPU driver and application.
>>
>> IVSC also provides a privacy mode. When privacy mode is turned on,
>> camera sensor can't be used. This means that both ACE and host IPU can't
>> get image data. And when this mode is turned on, host IPU driver is
>> informed via a registered callback, so that user can be notified.
> 
> How does the privacy mode work, and how can the user trust that the
> closed-source IVSC and IME firmwares will honour the privacy settings ?
>

Continue with question from Laurent,

How IVSC handle the privacy request from user? Is there some notification
mechanism to user-space? I'd have concern if IVSC driver need private callback
to request back-end(e.g. ISP driver) to handle stream cutting.

>> In summary, to acquire ownership of camera by IPU driver, first ACE
>> module needs to be informed of ownership and then to setup MIPI CSI-2
>> link for the camera sensor and IPU.
>>
>> Implementation:
>> There are two different drivers to handle ACE and CSI hardware modules
>> inside IVSC.
>>  - mei_csi: MEI client driver to send commands and receive notifications
>> from CSI module.
>>  - mei_ace: MEI client driver to send commands and get status from ACE
>> module.
>> Interface is exposed via ivsc.h to acquire and release camera sensor and
>> CSI-2 link.
> 
> Do I understand correctly, from your diagram below, that the
> communication between the IME and IVSC goes through SPI ?
> 
>> Below diagram shows connections of IVSC/ISH/IPU/Camera sensor.
>> -----------------------------------------------------------------------------
>> | Host Processor                                                            |
>> |                                                                           |
>> |       -----------------       -----------------       ---------------     |
>> |       |               |       |               |       |             | I2C |
>> |       |      IPU      |       |      ISH      |       |camera driver|--|  |
>> |       |               |       |               |       |             |  |  |
>> |       -----------------       -----------------       ---------------  |  |
>> |               |                       |                      |         |  |
>> |               |                       |               ---------------  |  |
>> |               |                       |               |             |  |  |
>> |               |                       |               | IVSC driver |  |  |
>> |               |                       |               |             |  |  |
>> |               |                       |               ---------------  |  |
>> |               |                       |                      |         |  |
>> ----------------|-----------------------|----------------------|---------|---
>>                 | CSI                   | I2C                  |SPI      |
>>                 |                       |                      |         |
>> ----------------|-----------------------|----------------      |         |
>> | IVSC          |                                       |      |         |
>> |               |                                       |      |         |
>> |       -----------------       -----------------       |      |         |
>> |       |               |       |               |       |      |         |
>> |       |      CSI      |       |      ACE      |       |------|         |
>> |       |               |       |               |       |                |
>> |       -----------------       -----------------       |                |
>> |               |                       | I2C           |                |
>> ----------------|-----------------------|----------------                |
>>                 | CSI                   |                                |
>>                 |                       |                                |
>>             --------------------------------                             |
>>             |                              | I2C                         |
>>             |         camera sensor        |-----------------------------|
>>             |                              |
>>             --------------------------------
>>
>> Wentong Wu (3):
>>   media: pci: intel: ivsc: Add CSI submodule
>>   media: pci: intel: ivsc: Add ACE submodule
>>   media: pci: intel: ivsc: Add acquire/release API for ivsc
>>
>>  drivers/media/pci/Kconfig              |   1 +
>>  drivers/media/pci/intel/Makefile       |   2 +
>>  drivers/media/pci/intel/ivsc/Kconfig   |  12 +
>>  drivers/media/pci/intel/ivsc/Makefile  |   7 +
>>  drivers/media/pci/intel/ivsc/ivsc.c    |  84 +++++
>>  drivers/media/pci/intel/ivsc/mei_ace.c | 472 +++++++++++++++++++++++++
>>  drivers/media/pci/intel/ivsc/mei_ace.h |  36 ++
>>  drivers/media/pci/intel/ivsc/mei_csi.c | 342 ++++++++++++++++++
>>  drivers/media/pci/intel/ivsc/mei_csi.h |  60 ++++
>>  include/linux/ivsc.h                   |  74 ++++
>>  10 files changed, 1090 insertions(+)
>>  create mode 100644 drivers/media/pci/intel/ivsc/Kconfig
>>  create mode 100644 drivers/media/pci/intel/ivsc/Makefile
>>  create mode 100644 drivers/media/pci/intel/ivsc/ivsc.c
>>  create mode 100644 drivers/media/pci/intel/ivsc/mei_ace.c
>>  create mode 100644 drivers/media/pci/intel/ivsc/mei_ace.h
>>  create mode 100644 drivers/media/pci/intel/ivsc/mei_csi.c
>>  create mode 100644 drivers/media/pci/intel/ivsc/mei_csi.h
>>  create mode 100644 include/linux/ivsc.h
> 

-- 
Best regards,
Bingbu Cao
