Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD327297CD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbjFILHJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Jun 2023 07:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjFILHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:07:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F98F1FDC;
        Fri,  9 Jun 2023 04:07:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qcys02y3Lz6J7wD;
        Fri,  9 Jun 2023 19:04:36 +0800 (CST)
Received: from localhost (10.126.170.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 9 Jun
 2023 12:06:57 +0100
Date:   Fri, 9 Jun 2023 12:06:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH v2 1/4] cxl: add a firmware update mechanism using the
 sysfs firmware loader
Message-ID: <20230609120656.0000554b@Huawei.com>
In-Reply-To: <6666972e336a6749f24ce3aab7dddad63a796974.camel@intel.com>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
        <20230602-vv-fw_update-v2-1-e9e5cd5adb44@intel.com>
        <20230608154905.00007551@Huawei.com>
        <6666972e336a6749f24ce3aab7dddad63a796974.camel@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.126.170.42]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >   
> > > +       struct fw_upload *fwl;
> > > +       int rc;
> > > +
> > > +       if (!test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO, cxlds->enabled_cmds))
> > > +               return 0;
> > > +
> > > +       fwl = firmware_upload_register(THIS_MODULE, &cxlmd->dev,
> > > +                                      dev_name(&cxlmd->dev),
> > > +                                      &cxl_memdev_fw_ops, cxlds);
> > > +       if (IS_ERR(fwl)) {
> > > +               dev_err(&cxlmd->dev, "Failed to register firmware loader\n");
> > > +               return PTR_ERR(fwl);  
> > 
> > It's called from probe only so could use dev_err_probe() for slight
> > simplification.  
> 
> From what I can tell, this ends up looking like:
> 
> 	fwl = firmware_upload_register(THIS_MODULE, dev,
> dev_name(dev),
> 				       &cxl_memdev_fw_ops, cxlds);
> 	rc = dev_err_probe(dev, PTR_ERR(fwl),
> 			   "Failed to register firmware loader\n");
> 	if (rc)
> 		return rc;
> 
> Is that what you meant? Happy to make the change if so.

	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
				       &cxl_memdev_fw_ops, cxlds);
	if (IS_ERR(fwl)
		return dev_err_probe(dev, PTR_ERR(fwl),
				     "Failed to register firmware loader\n");



