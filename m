Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2332D6299BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiKONM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiKONM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:12:58 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C62FE7;
        Tue, 15 Nov 2022 05:12:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKc4eg2Kp/3CPEeYLA6JTlUZvvYfd2c7a1XJl3E/SGvJbbBH+SotJ8kB4fnjyQbBw9Ky5nlZ7U0mVdEVbDTG88j6Bz+txVcJQaOJ29yvY5V0KX0OdGzzXztTcY0QkRwqcIygrixncyxz+PtrNwnkJEIH8X1w19mvA4JFOOdgfenzxuuQ1NMCKcZXXIlZdH987kBWBC6eSlV2FPQYbJ4V6zm1+v/UIkl9pExc/rhAw8Wji4DyvZ+ZLOAlhasoyo3ARtGTGFC1nQjiJHgHvNfjGz/KJ/jvFfI7pCVHCokp3jpFKWpRnfcBXu6rtpKGp1aA6n5IErwweCWIIFuwqM8XAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4t2fvQ55H2ZFDSxg4X94uSUs6kUTd7H6KhQ1FTw6w0=;
 b=hpz2lWxJUdZH8VgUpU75OQn9FM/3FkUBuahRsNPGeG/p7OXgizjcRmWRYMLvWCPYIYo2d4hR/1yMe7TA1jmhRHum1asUh4DKfcDaIXo5GPDp2gES/VFzQZSavFvE+bie4hgua2WKL18vJ/MhyfNmnXYxx0FAp48EBUsw2Q/jpVIzuJZQXsCa671+j6P79va65zOwF/N51qBcTg7QPK0Ld55EdejpiF3m2KiL+eyndMvHlat7eCoZbIlxDulQdFxo7IGvc7gtAhsC+x2K1vkusrDrkmr0pPfoOcQsP5slyjGA7OJAxzrxLUeKTg9qvL4mEHGiEVE/xj/ldC/V/0LQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4t2fvQ55H2ZFDSxg4X94uSUs6kUTd7H6KhQ1FTw6w0=;
 b=OEaoYADowILTdFhCfC/hgscOc2DacGnOsqJM+Om4RPx+BixXthWeDsudoTwGpJzcl8XpVUbwe2b4PQ5zZxkG1Vpv4A/rwzmMn1I3pUeATcoHsTK7enqWzmE1UmMY5sdCBddit3ieKUJl9Gkpcb0lzi/psSoTMO0cAtgfFFh6ASM=
Received: from BN7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:408:34::17)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 13:12:54 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::69) by BN7PR06CA0040.outlook.office365.com
 (2603:10b6:408:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 13:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 13:12:54 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 07:12:51 -0600
Date:   Tue, 15 Nov 2022 14:12:48 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 3/9] cxl/mem: Adjust cxl_mem_find_port() to find an
 RCH's port
Message-ID: <Y3OQUAriOj2NxLfO@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-4-rrichter@amd.com>
 <6372d30ef4152_12cdff29452@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6372d30ef4152_12cdff29452@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|MN2PR12MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b8bf86-90ec-4f8e-59e6-08dac70b1b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbfLsb624jubY/tsNKxGeqJeYs6TvoIft/iCjz7dSBCYWabCrwM2RuYcnKspeltCzVBhkClylI207DVmFlT/iFr0EHZVdKH4qNoKy04mgZZIiAx1VnyS/Fo8zIyju3eAvQJmIuWnLRySKD7bU/IFD50wwpwZs70NWoQW4uFT8u0yhifDeIV7Lo0NNPrcD8GsYgsY8lPOZhUE+eaKUZrCE1rZ/9El67g0toAVXrDKvYdBmf2cycXfsQiMd6Uo6Woe1hw0pq2/RDY6YaWWlx8/SG6MH1Q1M+j45ml6bG61Ftrc9yZepmC4pjt0zuDlvCWalq/oQwaJARdfb2zwDC+q1t6ZcxhO01zSaf4X2x348X/QOEzkjupr6A8j7trShdb3xYu08uzlGU42SRPDvQ/+nHSC4c4rs7pzfRjqkB9KB9nhYt0IYtqAGvrG8fF2UCXI4TqLGVnlSqg6LeZEK+dTPbjP8/DmL1i9EvUeOaoT96bcEDkxyeNkLQTF77Gna4Yd3/I/3uc3579cEPqEU5fn2La3EPkIV7v6f3eeo76USmz/mJdlL93EjQM7IGM/BDsH4aB9rnWAoqYmJbSMBFssk/EKKuO+IA33Tm0gABl58Z9+1Hk6WnwDruql/YC8Wd+HPruhX3HpvKqWhlzvoExs92NQBnOLHpRw28C8su5x+a5CQ24noJQdKZqPdcrYi4YFmgYoT978PiEdFAHiJ5ROHulj/zQ9myybZPlHiUPIFpUxS2NjjqFhBZ/k0ygGFhRhvUlzCIqqKabHP97RpTEctLan+W9itytx8yeAe+/jmvz3uUC3uwk6TaYec3AYTFzB7yQoJXwQSM2H2UsNxUxv4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(82740400003)(356005)(70206006)(41300700001)(8936002)(81166007)(82310400005)(5660300002)(70586007)(316002)(4326008)(8676002)(2906002)(7696005)(7416002)(336012)(26005)(40480700001)(426003)(16526019)(55016003)(9686003)(47076005)(186003)(53546011)(478600001)(6666004)(54906003)(6916009)(40460700003)(37363002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 13:12:54.1188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b8bf86-90ec-4f8e-59e6-08dac70b1b39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.22 15:45:19, Dan Williams wrote:
> Robert Richter wrote:
> > The PCIe software view of an RCH and RCD is different to VH mode. An
> > RCD is paired with an RCH and shows up as RCiEP with a parent already
> > pointing to a PCI bridge (struct pci_host_bridge). In contrast, in VH
> > mode an PCI Express Endpoint is a PCI type 0 device with a PCI type 1
> > device as parent (struct pci_dev, most of the time a downstream switch
> > port, but could also be a root port). The following hierarchy applies
> > in VH mode:
> > 
> >  CXL memory device, cxl_memdev                               endpoint
> >  └──PCIe Endpoint (type 0), pci_dev                           |
> >     └──Downstream Port (type 1), pci_dev (Nth switch)        portN
> >        └──Upstream Port (type 1), pci_dev (Nth switch)        |
> >           :                                                   :
> >           └──Downstream Port (type 1), pci_dev (1st switch)  port1
> >              └──Upstream Port (type 1), pci_dev (1st switch)  |
> >                 └──Root Port (type 1), pci_dev                |
> >                    └──PCI host bridge, pci_host_bridge       port0
> >                       :                                       |
> >                       :..ACPI0017, acpi_dev                  root
> > 
> >  (There can be zero or any other number of switches in between.)
> > 
> > An iterator through the grandparents takes us to the root port which
> > is registered as dport to the bridge. The next port an endpoint is
> > connected to can be determined by using the grandparent of the memory
> > device as a dport_dev in cxl_mem_find_port().
> > 
> > The same does not work in RCD mode where only an RCiEP is connected to
> > the host bridge:
> > 
> >  CXL memory device, cxl_memdev                               endpoint
> >  └──PCIe Endpoint (type 0), pci_dev                           |
> >     └──PCI host bridge, pci_host_bridge                      port0
> >        :                                                      |
> >        :..ACPI0017, acpi_dev                                 root
> > 
> > Here, an endpoint is directly connected to the host bridge without a
> > type 1 PCI device (root or downstream port) in between. To link the
> > endpoint to the correct port, the endpoint's PCI device (parent of the
> > memory device) must be taken as dport_dev arg in cxl_mem_find_port().
> > 
> > Change cxl_mem_find_port() to find an RCH's port.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/port.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 0431ed860d8e..d10c3580719b 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1354,6 +1354,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> >  	return rc;
> >  }
> >  
> > +static inline bool is_cxl_restricted(struct cxl_memdev *cxlmd)
> > +{
> > +	struct device *parent = cxlmd->dev.parent;
> > +	if (!dev_is_pci(parent))
> > +		return false;
> > +	return pci_pcie_type(to_pci_dev(parent)) == PCI_EXP_TYPE_RC_END;
> > +}
> > +
> >  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> >  {
> >  	struct device *dev = &cxlmd->dev;
> > @@ -1433,9 +1441,39 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
> >  
> > +/*
> > + * CXL memory device and port hierarchy:
> > + *
> > + * VH mode:
> > + *
> > + * CXL memory device, cxl_memdev                               endpoint
> > + * └──PCIe Endpoint (type 0), pci_dev                           |
> > + *    └──Downstream Port (type 1), pci_dev (Nth switch)        portN
> > + *       └──Upstream Port (type 1), pci_dev (Nth switch)        |
> > + *          :                                                   :
> > + *          └──Downstream Port (type 1), pci_dev (1st switch)  port1
> > + *             └──Upstream Port (type 1), pci_dev (1st switch)  |
> > + *                └──Root Port (type 1), pci_dev                |
> > + *                   └──PCI host bridge, pci_host_bridge       port0
> > + *                      :                                       |
> > + *                      :..ACPI0017, acpi_dev                  root
> > + *
> > + * (There can be zero or any other number of switches in between.)
> > + *
> > + * RCD mode:
> > + *
> > + * CXL memory device, cxl_memdev                               endpoint
> > + * └──PCIe Endpoint (type 0), pci_dev                           |
> > + *    └──PCI host bridge, pci_host_bridge                      port0
> > + *       :                                                      |
> > + *       :..ACPI0017, acpi_dev                                 root
> > + */
> >  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
> >  				   struct cxl_dport **dport)
> >  {
> > +	if (is_cxl_restricted(cxlmd))
> > +		return find_cxl_port(cxlmd->dev.parent, dport);
> > +
> >  	return find_cxl_port(grandparent(&cxlmd->dev), dport);
> 
> I do not see why this change is needed. For example:
> 
> # readlink -f /sys/bus/cxl/devices/mem0
> /sys/devices/pci0000:38/0000:38:00.0/mem0
> # cxl list -BT
> [
>   {
>     "bus":"root0",
>     "provider":"ACPI.CXL",
>     "nr_dports":1,
>     "dports":[
>       {
>         "dport":"pci0000:38",
>         "id":49
>       }
>     ]
>   }
> ]
> 
> ...so, in this case, the grandparent of "mem0" is "pci0000:38", and
> "pci0000:38" is a dport. Unmodified cxl_mem_find_port() will do the
> right thing and find that this CXL RCIEP is directly connected to
> "root0".

find_cxl_port() uses the dport_dev, not the uport_dev. A lookup of
pci0000:38 gives the cxl root (ACPI.CXL). Instead, the endpoint's
device (0000:38:00.0) must be used to get to the bridge
("pci0000:38").

There is a parent missing because there is no Root Port in the RCD
hierarchy, simplified example:

VH mode:

 CXL memory device, cxl_memdev                         endpoint <- cxlmd
 └──PCIe Endpoint (type 0), pci_dev                     |
    └──Downstream Port (type 1), pci_dev (1st switch)  port1    <- port1: registered as dport at port0
       └──Upstream Port (type 1), pci_dev (1st switch)  |          port1: grandparent(cxlmd)
          └──Root Port (type 1), pci_dev                |	<- pdev:  registered as dport at port0
             |                                          |          pdev:  grandparent(port1)
             └──PCI host bridge, pci_host_bridge       port0    <- find_cxl_port(grandparent(grandparent(cxlmd)))
                :                                       |          port0 enumerates root ports (pdev) as dports
                :..ACPI0017, acpi_dev                  root

Additional switches add another grandparent() level each (adding an
dport and uport).

RCD mode:

 CXL memory device, cxl_memdev                         endpoint <- cxlmd
 └──PCIe Endpoint (type 0), pci_dev                     |       <- pdev: registered as dport at port0
    |                                                   |          pdev: parent(cxlmd)
    └──PCI host bridge, pci_host_bridge                port0    <- find_cxl_port(parent(endpoint))
       :                                                |          port0 enumerates endpoint (RCiEP) as dports
       :..ACPI0017, acpi_dev                           root

I hope I could shed some light here.

-Robert
