Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6D56FE0A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbjEJOmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbjEJOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:42:20 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 07:42:19 PDT
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6600C55A2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=709; q=dns/txt; s=iport;
  t=1683729739; x=1684939339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7RnPl13OyYFSy+YWgrlrfVWl2glDCa70vHjcwnO1YZw=;
  b=IO0MOhDNS8CvQ5LoTdLNoXmsBX6l3X2SQlPfNpqFSuiHEtOq8Dinacby
   hHGDtvUN5V/me8zg4qgr5T9LsEG42XD761ErYzTMeiYy0TqePUoU1Whdg
   mvwkaMnYEcjphqtQtMHHrYE+7KdtNfT+LlIGnnCTJtJD5WfN8dLRKVgxE
   s=;
X-IronPort-AV: E=Sophos;i="5.99,264,1677542400"; 
   d="scan'208";a="55053121"
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 10 May 2023 14:41:17 +0000
Received: from sjc-ads-7449.cisco.com (sjc-ads-7449.cisco.com [10.30.220.234])
        by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 34AEfG3E001846
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 May 2023 14:41:17 GMT
Received: by sjc-ads-7449.cisco.com (Postfix, from userid 1777032)
        id 81DD2CCD0B1; Wed, 10 May 2023 07:41:16 -0700 (PDT)
From:   Marcin Wierzbicki <mawierzb@cisco.com>
To:     rogerq@kernel.org
Cc:     mawierzb@cisco.com, bwawrzyn@cisco.com, danielwa@cisco.com,
        kishon@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, olicht@cisco.com,
        sjakhade@cadence.com, u.kleine-koenig@pengutronix.de,
        vkoul@kernel.org, xe-linux-external@cisco.com
Subject: Re: [PATCH v2] phy: cadence: Sierra: Add single link SGMII register configuration
Date:   Wed, 10 May 2023 14:40:56 +0000
Message-Id: <20230510144056.3648269-1-mawierzb@cisco.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20230508160142.2489365-1-mawierzb@cisco.com>
References: <20230508160142.2489365-1-mawierzb@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.220.234, sjc-ads-7449.cisco.com
X-Outbound-Node: rcdn-core-12.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> On 08/05/2023 19:01, Marcin Wierzbicki wrote:
>> Add single link SGMII register configuration for no SSC for
>> cdns,sierra-phy-t0 compatibility string.
>> The configuration is based on Sierra Programmer's Guide and validated
>> in Cisco CrayAR SoC.
>>
>> Co-developed-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
>> Signed-off-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
>> Signed-off-by: Marcin Wierzbicki <mawierzb@cisco.com>
>> Change-Id: Id4c093a1bbf409f3176736b5326854a1396391c1
>> ---

> What changed in v2?

This is actually a rebased version of the v1 (in the meantime there have been some SGMII related changes). Should have mentioned that before.

Best regards,
Marcin
