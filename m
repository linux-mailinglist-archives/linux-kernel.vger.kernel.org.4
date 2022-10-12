Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF0A5FC5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJLNEr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Oct 2022 09:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJLNEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:04:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93816308;
        Wed, 12 Oct 2022 06:04:35 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MnXrL5Hn8z67XMQ;
        Wed, 12 Oct 2022 21:02:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 12 Oct 2022 15:04:32 +0200
Received: from localhost (10.45.159.48) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 12 Oct
 2022 14:04:32 +0100
Date:   Wed, 12 Oct 2022 14:04:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Robert Richter" <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Terry Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH 1/2] efi/cper, cxl: Decode CXL Protocol Error Section
Message-ID: <20221012140430.00003a93@huawei.com>
In-Reply-To: <4a7ee633-037f-9064-7e95-9fdcdbfb5fe0@amd.com>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
        <20221007211714.71129-2-Smita.KoralahalliChannabasappa@amd.com>
        <20221010152415.0000113b@huawei.com>
        <4a7ee633-037f-9064-7e95-9fdcdbfb5fe0@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.45.159.48]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +	if (prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) {
> >> +		switch (prot_err->agent_type) {
> >> +		case RCD:
> >> +			pr_info("%s lower_dw: 0x%08x, upper_dw: 0x%08x\n", pfx,
> >> +				prot_err->dev_serial_num.lower_dw,
> >> +				prot_err->dev_serial_num.upper_dw);
> >> +			break;
> >> +		default:
> >> +			break;
> >> +		}
> >> +	}  
> > Nice to pretty print the cap structure and appropriate DVSEC and Error logs as well
> > if valid, but that could be a follow up patch.  
> 
> Hmm, I have added the Error log decoding support in the next patch.
> 
> But, I did not include cap structure and DVSEC though as I initially 
> thought it might not be
> that important to parse the error. Do you recommend adding them?

Given it would be straight forward to do, probably better to supply slightly too
much info than miss one particular chunk out.
> >  
> >> +struct cper_sec_prot_err {
> >> +	u64			valid_bits;
> >> +	u8			agent_type;
> >> +	u8			reserved[7];
> >> +	union {
> >> +		u64		agent_addr;  
> > Perhaps useful to add a few comments to say when the different union
> > elements are relevant.  Perhaps also name the field as per the spec
> > which would give the overall union the agent_address.
> > I admit that is a little confusing with the union element having
> > the same name for when it's treated as an address.
> > Perhaps call the union element rcrb_base_addr?  
> 
> Okay, probably something like this?
> 
>      union {
>                      u64                rcrb_base_addr;
>                      struct {
>                                      u8    function;
>                                      u8    device;
>                                      u8    bus;
>                                      u16  segment;
>                                      u8    reserved_1[3];
>                      };
>      } agent_addr;
> 
> And change printing from prot_err->segment to prot_err->agent_addr.segment
> and so on.. Please ignore my indentation/alignments here..

Looks good to me.


> 
> >  
> >> +		struct {
> >> +			u8	function;
> >> +			u8	device;
> >> +			u8	bus;
> >> +			u16	segment;
> >> +			u8	reserved_1[3];
> >> +		};
> >> +	};
> >> +	struct {
> >> +		u16		vendor_id;	
> >> +		u16		device_id;
> >> +		u16		sub_vendor_id;
> >> +		u16		sub_device_id;  
> > This is always fun.  Far as I can tell not all PCI elements
> > have subsystem IDs - so who knows what goes in these..
> > Also, there is wonderfully no such thing as a PCI subsystem device ID.
> > It's just called subsystem ID in the PCI spec.  
> 
> Thanks for correcting this. Will fix.

UEFI spec is inconsistent with PCIe :( 


> 
> >  
> >> +		u8		class_code[2];  
> > Why treat class code as two u8s?  If doing so, shall
> > we name them?  base_class_code, sub_class_code?  
> 
> Just followed the PCI CPER decoding here.. Will name them if that makes
> more sense..
> 

ok. Fine as is.


> 
> >
> > 	} device_id;
> >  
> >> +	struct {
> >> +		u32		lower_dw;
> >> +		u32		upper_dw;
> >> +	}			dev_serial_num;
> >> +	u8			capability[60];
> >> +	u16			dvsec_len;
> >> +	u16			err_len;
> >> +	u8			reserved_2[4];  
> > You could add a [] array on the end to make it clear there are more elements.
> > That's not a perfect solution though given there are two different variable length
> > fields on the end.  They aren't that variable (as defined by the structures
> > in the CXL spec) however the complexity comes from the fact that they may not
> > be valid / lengths will be 0 (I assume lengths will be 0
> > if not valid anyway, the spec doesn't seem to say either way...)  
> 
> Hmm, I probably got the idea to do this way by referring to "efi/cper-x86.c"
> (N.2.4.2 IA32/X64 Processor Error Section in UEFI spec) and probably at few
> places under the APEI tables.

Ah. I didn't check for precedence.  Down to maintainer preference then.

> 
> Also to note, defining the new variable array member the parsing needs 
> to be changed
> accordingly in the next patch.  Add dvsec length to this new variable array
> member to get to the Error Log field. Am I right?

Yes.

Jonathan

