Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A291A6CB102
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjC0Vvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0Vvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:51:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6625E2D66;
        Mon, 27 Mar 2023 14:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaJzxKzAD12h/DeNCvjNrREvE9pJ2vK9q+l5TsW/usDtF6Kc2g/FM17jgLJhPnrnPKUq7qURzuhUMEQ5t4761Ewa6gm1lzBmvAL9yHrxZ0nq3J4cDQhfybiQj3yTCamkbp237Re1SjOTUpm7FzQGv2kFi1sB7O6dE0OtcycjNIJkdYw2VieH838jHLSD8iB2cISofDYeG5bySznaCyP4RXg6P2siL6MZvYoYhkGqs1t5WgYC9MkqnPOYOMtimWsSXugydUyE5eYe+2uiDQQ9AK7TbUM7CdyoQSYu76k53oMDzgu36uKYsyeFWwVx1pjB3/NCAOorSvndTmB965Cy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFQHAh/BpWNRHnd1kvgVeQgj05l32vTbFswnzVs8yg4=;
 b=Q1Ww7Z2ypGgo7vNriF/oVOE6WONYJzTqzr5q5duenwayOnZKCsEoUw3wVRVj/YnwdI6A9iCIEtJH5csaXGBUSX1DE7BUq4kiA3iOLHrchpuDSnxnToRk/sYo5KqseFg+xGaz1Poh31b8doe0+sT/Yf89h/tsPQRTJVbHLP/KOoee4MjutaViEsD7NT/rDR3hDVcEhqb1E2+upk4u8GfONUgipLLqfd/x2RszaoviHcyx4tbYK8WPM+e2N1K+D6qf+/+pmY1RyDXXAugVbYNq/S7Npnltu1WwCFli59zROXCoFzJSi6cNvtRAj0BkWR9Flm/cqmBiNYy6SeD4veGhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFQHAh/BpWNRHnd1kvgVeQgj05l32vTbFswnzVs8yg4=;
 b=SNG1f3k1uWBhBqrAhBT2bkxQlZGQ89J+ig9AncNG2StCHrez077VHt1Z3gSvs8oabbY1mb6ZmwiIX/YCR5UVA/F98aCfNWqm1tdnCRE2Su0rf/tWJbBxLeg56YKBqQ577pfh+tVVnN33WIfWRmFk9qMUMi6TdGDNscTpynO8Kd0=
Received: from DM6PR02CA0114.namprd02.prod.outlook.com (2603:10b6:5:1b4::16)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 21:51:45 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::12) by DM6PR02CA0114.outlook.office365.com
 (2603:10b6:5:1b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 21:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 21:51:45 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 16:51:42 -0500
Date:   Mon, 27 Mar 2023 23:51:39 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v2 4/5] cxl/pci: Forward RCH downstream port-detected
 errors to the CXL.mem dev handler
Message-ID: <ZCIPuPM+LZsOFIIZ@rric.localdomain>
References: <20230323213808.398039-5-terry.bowman@amd.com>
 <20230324223656.GA2660301@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230324223656.GA2660301@bhelgaas>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f1a313-4f41-45ab-5cfe-08db2f0d7543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0G3TeIC7QLTzUlrvhOnhdAosH49pivGL94PO+FIEiAW8p/9roPUurD8q/2mL/DH0Y9uyGLb73So+jChjUFKiyUhWgVn6+hg70h5DJsG3HGF9eLkChRB9TOKPj/6af6qo5r8gvo6xs2/AMXgc6RrdNMSFs+1J/qvm2HGI7iOWsPDQaH/HmydFjbgAdtH5r+6nFPGCIUHJhLTst7tLKxlOhv+R8mV0iWtW8CZDWLiv2UMcn83pbNM6pvGzPyrWyt3GSAUZg9VnloxSAPV+rPUsb+M4utNltE8SY2NRG2ZZB4fZumgZJ63C52X062+DUWrIk0YLR15Wsu+c82w8DK1zDli46wBIEZbEdfUPq5H7QolNNU/6sItBlejO8bGIK999CRIdf7ziiT7EWIhi8PNt3gL4EApssyOqadMX96SQ2aaKj41vf7tolo3i8Ko+UKYSwadWcW9pga/HJ+rAuBki4VJ6lCavGPcFHDDZzXuzM4QyjiMiKGxPfnmlAe9D57LoVpdINRFTQYp4xz99ktR5R5MaA69Az+9gzKdiT/P9cToJHKcaarFF76m4L65imbaB1hU5aJH01Zk59V/QzXWZuDHHgTHs7nVdnr1V/Febv0h0r6QWMJ5zFJt+GBL8sNfnrx0yFeK+OrrJGqkkLo4S9hhFjdgES2dj3uH7qvEu8Vd4dfrc+3hmk1k/UWFanJt89TbZew/lttJWzmXbLGeWyz6NRpxDoovhSPRO/aAjeI7BmK1QLe/zBLkoXj40RUaGdLldmaG0QKclEJE0xNX8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(16526019)(9686003)(26005)(53546011)(426003)(40480700001)(41300700001)(186003)(55016003)(6666004)(7696005)(83380400001)(336012)(47076005)(478600001)(54906003)(316002)(36860700001)(40460700003)(4326008)(70206006)(2906002)(7416002)(70586007)(8676002)(6916009)(81166007)(82740400003)(356005)(82310400005)(5660300002)(8936002)(67856001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 21:51:45.0861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f1a313-4f41-45ab-5cfe-08db2f0d7543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

thanks for you review.

On 24.03.23 17:36:56, Bjorn Helgaas wrote:
> I'd call this a "PCI/AER: ..." patch since that's where all the
> changes are.
> 
> On Thu, Mar 23, 2023 at 04:38:07PM -0500, Terry Bowman wrote:
> > From: Robert Richter <rrichter@amd.com>
> > 
> > In RCD mode a CXL device (RCD) is exposed as an RCiEP, but CXL
> > downstream and upstream ports are not enumerated and not visible in
> > the PCIe hierarchy. Protocol and link errors are sent to an RCEC.
> 
> "RCD" isn't a common term in drivers/pci; can you expand it once here?
> 
> > Now, RCH downstream port-detected errors are signaled as internal AER
> > errors (UIE/CIE) with the RCEC's source ID. A CXL handler must then
> 
> Similarly, "UIE" and "CIE" are new to drivers/pci; can you expand them
> before using?  I assume Uncorrectable Internal Error (UIE) and
> Corrected Internal Error (CIE)?  (Annoying that the PCIe spec uses
> "Correctable" in general, but "Corrected" for Internal Errors.)
> 
> > inspect the error status in various CXL registers residing in the
> > dport's component register space (CXL RAS cap) or the dport's RCRB
> > (AER ext cap). [1]
> > 
> > This patch connects errors showing up in the RCEC's error handler with
> 
> "Connect errors ..." (we already know this text applies to *this
> patch*).

I will update subject and description.

> 
> > the CXL subsystem. Implement this by forwarding the error to all CXL
> > devices below the RCEC. Since the entire CXL device is controlled only
> > using PCIe Configuration Space of device 0, Function 0, only pass it
> > there [2]. These devices have the Memory Device class code set
> > (PCI_CLASS_MEMORY_CXL, 502h) and the existing cxl_pci driver can
> > implement the handler.
> 
> > The CXL device driver is then responsible to
> > enable error reporting in the RCEC's AER cap
> 
> I don't know exactly what you mean by "error reporting in the RCEC's
> AER cap", but IIUC, for non-Root Port devices, generation of ERR_COR/
> ERR_NONFATAL/ERR_FATAL messages is controlled by the Device Control
> register and should already be enabled by pci_aer_init().
> 
> Maybe you mean setting AER mask/severity specifically for Internal
> Errors?  I'm hoping to get as much of AER management as we can in the

Richt, this is implemented in patch #5 in function
rcec_enable_aer_ints().

> PCI core and out of drivers, so maybe we need a new PCI interface to
> do that.
> 
> In any event, I assume this sort of configuration would be an
> enumeration-time thing, while *this* patch is a run-time thing, so
> maybe this information belongs with a different patch?

Do you mean once a Restricted CXL host (RCH) is detected, the internal
errors should be enabled in the device mask, all this done during
device enumeration? But wouldn't interrupts being enabled then before
the CXL device is ready?

> 
> > (esp. CIE and UIE) and to
> > inspect the dport's CXL registers in addition (CXL RAS cap and AER ext
> > cap).
> > 
> > The reason for choosing this implementation is that a CXL RCEC device
> > is bound to the AER port driver, but the driver does not allow it to
> > register a custom specific handler to support CXL. Connecting the RCEC
> > hard-wired with a CXL handler does not work, as the CXL subsystem
> > might not be present all the time. The alternative to add an
> > implementation to the portdrv to allow the registration of a custom
> > RCEC error handler isn't worth doing it as CXL would be its only user.
> > Instead, just check for an CXL RCEC and pass it down to the connected
> > CXL device's error handler.
> > 
> > [1] CXL 3.0 spec, 12.2.1.1 RCH Downstream Port-detected Errors
> > [2] CXL 3.0 spec, 8.1.3 PCIe DVSEC for CXL Devices
> > 
> > Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Since you're sending this patch (Terry) your Signed-off-by should be
> last.
> 
> > Cc: "Oliver O'Halloran" <oohall@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-pci@vger.kernel.org
> > ---
> >  drivers/pci/pcie/aer.c | 45 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 7f0f52d094a4..d250a4caa85a 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -943,6 +943,49 @@ static bool find_source_device(struct pci_dev *parent,
> >  	return true;
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_CXL_PCI)
> > +
> > +static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info);
> > +
> > +static int handle_cxl_error_iter(struct pci_dev *dev, void *data)
> > +{
> > +	struct aer_err_info *e_info = (struct aer_err_info *)data;
> > +
> 
> Thanks for explaining the :00.0 in the commit log.  I think a one-line
> comment here would be useful too so future readers don't have to dig
> out the commit to understand.

Sure, will add a comment.

> 
> > +	if (dev->devfn != PCI_DEVFN(0, 0))
> > +		return 0;
> > +
> > +	/* Right now there is only a CXL.mem driver */
> > +	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> > +		return 0;
> > +
> > +	/* pci_dev_put() in handle_error_source() */
> > +	dev = pci_dev_get(dev);

This dev is the endpoint's device handle.

> 
> I don't see why you need this.  Didn't we get here via this path?
> 
>   aer_isr
>     aer_isr_one_error
>       find_source_device
>         find_device_iter
>           if (is_error_source())
>             add_error_device
>               pci_dev_get          <-- existing pci_dev_get()

This is the RCEC's device handle. Note that downstream port errors
have the RCEC's error source id (the RCEC’s Bus, Device, and Function
Numbers, see CXL 3.0, 12.2.1.1). We pass this error to the CXL
endpoint's driver (RCD, the RCiEP) now. The iterator goes through all
endpoints connected to the RCEC.

>       aer_process_err_devices
>         for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++)
>           if (aer_get_device_error_info(e_info->dev[i], e_info))
>             handle_error_source
>   +           handle_cxl_error

For the endpoint we further call here now:

                  pcie_walk_rcec(dev, handle_cxl_error_iter, info)
                    handle_cxl_error_iter(endpoint_dev)
		      pci_dev_get(endpoint_dev)
                      handle_error_source(endpoint_dev)
                        pci_dev_put(endpoint_dev)

>               pci_dev_put(dev)     <-- existing pci_dev_put()
> 
> So it looks like we wouldn't call handle_error_source() unless we had
> a valid e_info->dev[i], which has already had pci_dev_get() called on
> it.
> 
> Oh, I think I see ... handle_cxl_error() itself was called because an
> RCEC reported an error on behalf of a CXL RCiEP (?), and then you use
> pcie_walk_rcec() to look through all the associated RCiEPs, and
> recursively call handle_error_source(), and we haven't acquired a
> reference to those RCiEPs.  Right?

Yes, exacly.

> 
> But I thought the CXL things were not enumerated (first paragraph of
> commit log)?  But obviously these RCiEPs must be enumerated as PCI
> devices or pcie_walk_rcec() and pci_dev_get() wouldn't work.

The dport and uport are not enumerated, there are two RCRB ranges for
them. But errors are reported using the PCI hierarchy, using the RCEC
and the RCiEP. Once an internal error arrives with the RCEC as an
error source, the AER err cap in the RCRB must be checked.

> 
> I haven't worked all the way through this, but I thought Sean Kelley's
> and Qiuxu Zhuo's work was along the same line and might cover this,
> e.g.,
> 
>   a175102b0a82 ("PCI/ERR: Recover from RCEC AER errors")
>   579086225502 ("PCI/ERR: Recover from RCiEP AER errors")
>   af113553d961 ("PCI/AER: Add pcie_walk_rcec() to RCEC AER handling")
> 
> But I guess maybe it's not quite the same case?

Actually, we use this code to handle errors that are reported to the
RCEC and only implement here the CXL specifics. That is, checking if
the RCEC receives something from a CXL downstream port and forwarding
that to a CXL handler (this patch). The handler then checks the AER
err cap in the RCRB of all CXL downstream ports associated to the RCEC
(not visible in the PCI hierarchy), but discovered through the :00.0
RCiEP (patch #5).

> 
> If you *do* need this, I know pci_dev_get(NULL) is a no-op, but since
> you're testing for NULL anyway, I'd put it inside the "if" body.
> 
> > +	if (dev)
> > +		handle_error_source(dev, e_info);

The check is more for the (theoretical) case where we cannot increment
the refcount.

> > +
> > +	return 0;
> > +}
> > +
> > +static bool is_internal_error(struct aer_err_info *info)
> > +{
> > +	if (info->severity == AER_CORRECTABLE)
> > +		return info->status & PCI_ERR_COR_INTERNAL;
> > +
> > +	return info->status & PCI_ERR_UNC_INTN;
> > +}
> > +
> > +static void handle_cxl_error(struct pci_dev *dev, struct aer_err_info *info)
> > +{
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> > +	    is_internal_error(info))
> 
> What's unique about Internal Errors?  I'm trying to figure out why you
> wouldn't do this for *all* CXL errors.

Per CXL specification downstream port errors are signaled using
internal errors. All other errors would be device specific, we cannot
handle that in a generic CXL driver. Note these are only errors
reported to the RCEC with the RCEC as a source, the RCiEP's errors are
handled using standard reporting already, see aer_isr_one_error() and
further calling pdrv->err_handler->cor_error_detected() or
pdrv->err_handler->error_detected().

-Robert

> 
> > +		pcie_walk_rcec(dev, handle_cxl_error_iter, info);
> > +}
> > +
> > +#else
> > +static inline void handle_cxl_error(struct pci_dev *dev,
> > +				    struct aer_err_info *info) { }
> > +#endif
> > +
> >  /**
> >   * handle_error_source - handle logging error into an event log
> >   * @dev: pointer to pci_dev data structure of error source device
> > @@ -954,6 +997,8 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
> >  {
> >  	int aer = dev->aer_cap;
> >  
> > +	handle_cxl_error(dev, info);
> > +
> >  	if (info->severity == AER_CORRECTABLE) {
> >  		/*
> >  		 * Correctable error does not need software intervention.
> > -- 
> > 2.34.1
> > 
