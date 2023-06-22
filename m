Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3BC73A1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjFVNUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFVNUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:20:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C86E7E;
        Thu, 22 Jun 2023 06:20:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1Cy6fyTz6J6Bn;
        Thu, 22 Jun 2023 21:18:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:20:02 +0100
Date:   Thu, 22 Jun 2023 14:20:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v6 15/27] cxl/port: Store the port's Component Register
 mappings in struct cxl_port
Message-ID: <20230622142001.000016ac@Huawei.com>
In-Reply-To: <20230622035126.4130151-16-terry.bowman@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
        <20230622035126.4130151-16-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 22:51:14 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> CXL capabilities are stored in the Component Registers. To use them,
> the specific I/O ranges of the capabilities must be determined by
> probing the registers. For this, the whole Component Register range
> needs to be mapped temporarily to detect the offset and length of a
> capability range.
> 
> In order to use more than one capability of a component (e.g. RAS and
> HDM) the Component Register are probed and its mappings created
> multiple times. This also causes overlapping I/O ranges as the whole
> Component Register range must be mapped again while a capability's I/O
> range is already mapped.
> 
> Different capabilities cannot be setup at the same time. E.g. the RAS
> capability must be made available as soon as the PCI driver is bound,
> the HDM decoder is setup later during port enumeration. Moreover,
> during early setup it is still unknown if a certain capability is
> needed. A central capability setup is therefore not possible,
> capabilities must be individually enabled once needed during
> initialization.
> 
> To avoid a duplicate register probe and overlapping I/O mappings, only
> probe the Component Registers one time and store the Component
> Register mapping in struct port. The stored mappings can be used later
> to iomap the capability register range when enabling the capability,
> which will be implemented in a follow-on patch.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
