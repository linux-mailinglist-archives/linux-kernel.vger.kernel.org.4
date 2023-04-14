Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AB16E292C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDNRUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDNRUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:20:51 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E023AA0;
        Fri, 14 Apr 2023 10:20:49 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33EHKggP108172;
        Fri, 14 Apr 2023 12:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681492842;
        bh=JF/2JgozJ0OBWGZ5LniP6mjhSeBRS0/u484NSdXRmu8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=FTajqF5DoEjE0NwKfj+MeJXONySICmmFOwYaCw+rEcZDt8l+lP/7sOZRSKdhl1Irf
         hlbvPq8Lz2zaPpsWWWzLKBA9td33KebTV3F4SgFnXKvJToHRBmXOllxw3Zcl3uMY6K
         XhxC7cInNoecEHi+413jPCWfFGuN0erx41vN81FM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33EHKgNu009448
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 12:20:42 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 12:20:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 12:20:42 -0500
Received: from [10.250.32.8] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33EHKfhh004216;
        Fri, 14 Apr 2023 12:20:42 -0500
Message-ID: <d9c98ab1-dc78-8f68-6a2d-28d9185d3294@ti.com>
Date:   Fri, 14 Apr 2023 12:20:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] serial: 8250_exar: Use PCI_DEVICE_DATA macro directly
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230413214421.6251-1-afd@ti.com>
 <ZDmIXoARLYXb8k9z@smile.fi.intel.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <ZDmIXoARLYXb8k9z@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 12:07 PM, Andy Shevchenko wrote:
> On Thu, Apr 13, 2023 at 04:44:20PM -0500, Andrew Davis wrote:
>> The EXAR_DEVICE macro was converted to use PCI_DEVICE_DATA, having
>> this macro at doesn't add much, remove it.
> 
> I'm not against this, but I have to point out that this patch brings
> inconsistency into the table. Either convert all, or none, I think.
> 

I did notice that, and was not sure how I feel about it either. The
issue is the others in the table have SUBDEVICE_IDs but we have
no simple macro for that.

Maybe what we need is a PCI_DEVICE_SUB_DATA() macro in pci.h, basically
it would be to PCI_DEVICE_SUB() what PCI_DEVICE_DATA() is to PCI_DEVICE().

Then I could re-consistify the table later with that. Thoughts?

Andrew

> That's why the patch that converts EXAR_DEVICE() to use PCI_DEVICE_DATA()
> had a little intrusion.
> 
> 
