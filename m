Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4A067D9E8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjAZXqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjAZXqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:46:02 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C2D11661;
        Thu, 26 Jan 2023 15:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674776749; x=1706312749;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bpi2AEyc0Sg1aL80dfD9sSJoexLnCDIggEPFa5pwAOY=;
  b=Y50n05d89fKSaq3KO+Nq/gar8fevMDfXKRXDCB4IXOTNrJy5/V6i+Dx2
   LUx6waGwhmQKUKaUghBKEQJa8aP3aS2Wnj07g9JMeGwyVe0tzL67uWavW
   dtoPHkVL8wSfmsedia4IbGSGSn4FOCZdNdFmtJY2vtmNyKcgH8mk5Cmih
   1jx1TDBa+aSo4uSzWAdLiW/AlVQFqZCeorVcuzy3bUvZYXN7laLPMY2Fu
   Img6mX2Dzj+/6+H8vg6V9WduPOCx0Vz7eEXAxFQ9U6uo7LYzRcjfn/C0o
   I47Slfx7cA91c3L0i6HijtGWi6HhEUz07OVEwEt8l02EmaPKoyVt6hTdd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="307332973"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="307332973"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 15:45:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="726483051"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="726483051"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2023 15:45:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 15:45:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 15:45:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 15:45:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 15:45:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8YQBylov8IuEj2t2SlKuqDg6b4gBDanCZdsNikwDgh01VkdfUHuL37o0OM9DoNO2qpudihsN/qN5anTVrIM5BivFxd3fg4fFqvfNfrm6gUzxqEYAlUsrz2P5siWbqTVQTUXTp1TWoxt83pnrhqs82zHj4MIWUGER6cD5oB4Y0DWvJKGQqdhiMDKSGDE7nvfzUoX2g8dFVNbC3XFZy8E3ESUnE/xQVrWphNVbSKOgti4rAz8bqUkmmns+yH7W5TMiHKBZBZtxgLReIQkrKVHJeMTjtuheKUxZdiUjKjf+OiOXuDU6nzYxnrzvrQWQpVA9Mo/S9ypoBQo9k63RmIFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ija8uZ0VhMPnseyGIQmJttCf8KAA/3HhGLtNu0F3JHs=;
 b=UTkvKC/SBRb7CdvL2YbcOg6FHlfckRtVeO8KoyxR2/vF1aNtE0nLhePea6Ii/mwYurJ1M51qfwRshNMTp2PCwlhgeraYX4vRGIC72Nb+Gnk2qJUGShlDqYLM5WPQ98jXv2VJrOcP5gW+BXoqvrTi15hiMxf6OA8cjqkrjBg6fqRPAtmrecZSeNTzJxzVOH9e7MqdCssvEMm/1WmbOWkBpETt5h7uMZizWZZXZWjD45aTNPXzlC5ckJw746l/7rkDmspTx/WoKGsIlm+Qw7EFsOaFAUDRpge3/scurdCgB9SiH38Lf0kSuQ/k6qRvS+WU8/NaD3NZpFqGyvGjQ4QgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6844.namprd11.prod.outlook.com (2603:10b6:930:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 23:45:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 23:45:45 +0000
Date:   Thu, 26 Jan 2023 15:45:43 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Add debug messages for supported mailbox
 commands
Message-ID: <63d310a768822_ea222294f0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230119130450.107519-1-rrichter@amd.com>
 <Y84dleBbsQhE0Dic@aschofie-mobl2>
 <Y85+dwjO9JjtFtGa@rric.localdomain>
 <Y87ff+zqVKf4oOJ/@aschofie-mobl2>
 <Y8/RuADVoRiC4d0+@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y8/RuADVoRiC4d0+@rric.localdomain>
X-ClientProxiedBy: BYAPR07CA0064.namprd07.prod.outlook.com
 (2603:10b6:a03:60::41) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: ee972902-6a54-4bbf-9da4-08dafff7719a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBIum3Be2H1IMy6OWuMIodGDlaYNLUN+pbiB4WbNq+ZAHP2zODzXQrTNPOjxlT1XGsn+nhFHNEbdIOTEPHaHNHCRiiRtzOgGg7nqxZhqs3fRElDQRHyyPWPrgbT9bYonFX3m7vF1WVpAlk1FBOw6JDW7yfKcClWGFKZBOGq7YINowKl7svuVRHUkWScI76TFizc1TJBxq1ND9vTclzKNGXiBfuHwJ7NIdNXIjj+NlzSYUgJsUaB0F38JHT8klMdWuhMLx3QNzNYRMzSWMzJvvxiToHBlBQOF2BwdQp4q1uiPpwgQ7bPNEnlubYCpkfjM9OxZG+9qqyyv+zrta+S/br3hy4eTzqktvg+2N5XLDgOjzY1KcxBwPRlGgMNXFzNUbxkO39H4f+4X5qiJme3cDFfav7YiWDvxZHFeIItXwYgNzZvFjvRpTs8pqRemnwzHdFr//gtfu9s8xVrnzMM2A2fkHkyFmMrFGF9+Bf2TrotiueT5TFZIeqMCzQHRqMn+Oo+SRl60a7OAzjXT03h3x/Y2BSk3VxO8xT5czjtJqWKN5UMjQkCY1ODj7WKGL6jAfJKH6GH94ttFkXeu9kkEPCAuuAPLYaOmaxhJEo7VOJqi0n/YUV0BH0jup6S3lm63n76sq58KdjyfkDF/KPgP5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199018)(316002)(54906003)(38100700002)(6636002)(41300700001)(15650500001)(8676002)(66476007)(66556008)(5660300002)(86362001)(8936002)(4326008)(66946007)(2906002)(82960400001)(6506007)(53546011)(110136005)(9686003)(26005)(6512007)(478600001)(186003)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yqRugaxbCwHjZ0qfGbQYPbVQcYKxTGorhLLG3rgiumPtwRkJHTCU/HBnV5nL?=
 =?us-ascii?Q?cO3DZ4Puwt7w0nkxICEgy1WPgJ98JtOrhDlqICFZtLMUWhcN02Xwb9UB4G6F?=
 =?us-ascii?Q?Y7gxgIUIds/nwVGUbEVwOruw4+QKAo/ChHntz0RjqrjOm+hghxTkt5Lg+g3L?=
 =?us-ascii?Q?QYE7wtVSx11cblXLUfqCOZl7yei2WDZoeYzt3g04G3387hqJPHpA42QdkGnV?=
 =?us-ascii?Q?/Ui4Wqx2uLNJ7qu7i3L2NhKhmdgZq3Vt26VGTMoIuPRRdB/cr+kVC03riywT?=
 =?us-ascii?Q?bM39h42jT+2PWbjDUlOcDLXncJcJcYL2fXVo5tiJuMwjLCDdi+lBzyawiA6t?=
 =?us-ascii?Q?W+EvZoSG10v9xSLVJmwVf8i0VBz3/3QDMhiZQfSPZbv9n1PEZK66iEdCp/Nh?=
 =?us-ascii?Q?wTmUWi7Al2iPpCYduMHu8fw1V6GIINJX1ITcXoCntvGsSuCn0YgXiwS1MHDt?=
 =?us-ascii?Q?XGWYQ274LHNnES7XLinJHKaYQvrQx5WXb6gs3+RTSXpq2znfFYRueXr//L84?=
 =?us-ascii?Q?ILTTsLUnKYLB/0Vjlky3nJNVklwLWQSjOjUYDpyW09MYKTioUw0SkC6+GZw/?=
 =?us-ascii?Q?PaWxfnWJVnuXKWIunI9ac9gavOpSaCHo5hjkNF5so702kyzfba8scwnPSLUi?=
 =?us-ascii?Q?OByCx55yeiKPOP6DsvPCVuHjK9i9hH6oiaJ7Zl3D824idu7RhPOkpQ5NtnlZ?=
 =?us-ascii?Q?AmjRha6HagA3XuHOAnt3al4u+ML3O8TPUdF3BCNqpjRMSCZAa2uR3F3cWg0S?=
 =?us-ascii?Q?uwgGcvblcMwjob5U68LD6KddtD0jw1MhjF8+Ob/J7p63qB9sS5RBwHXkoz5f?=
 =?us-ascii?Q?kDOx7dTosTjoBwPe6E1SrKtw/xmH914pviW7PJUCt1OTDBl4JsdT3tHTPU5o?=
 =?us-ascii?Q?TDyo4y28hOuLQJHChIl8RVmFiVqXw6tPLdPJTa5I0xVaJM1ONCV4L3ILVcGf?=
 =?us-ascii?Q?rMeDPHF2d0YlAa/JWUqQd6mzKyiWcunBYha6L+W9Dn21Z3thJgD5RWibo6Hx?=
 =?us-ascii?Q?1i2dNEqaI4oe0Jme/4hKlppIV1J+rgp+Mq0Z0VD0kIrG6ZsPTuSdHtXrLoRt?=
 =?us-ascii?Q?kWOHp7fyHgxOE4cfl33rHi3oy7wgmGMiPcQPuuZTyB6KdV7Sxd5U5FJbYCHe?=
 =?us-ascii?Q?FGt5EMowph9aPmCJI+Psd2l7qfWAw/eW5fvvg8csyMhI+a9dGdn92iPoeTIq?=
 =?us-ascii?Q?mu+8DsqTcPguNMEGhU7xMbaHI4nKbOenWTlRZPyScKbu2JynIdn+wmWDxDMB?=
 =?us-ascii?Q?JAyANmZb1b0Z3/pSVxGgZQ9GMob1cuGlilAjXRKlzCM+B2L/+10PobdMg7yt?=
 =?us-ascii?Q?LtZm6z5dYY1b1LkEviWz4OmU+EzNGiWaDPrIFMS9yrjXOxrjUQg6vM656Lx/?=
 =?us-ascii?Q?NI+u0scoajWase+Oh0ql2EL6zwhgwkKxRmjbP8CYwiSWcTDOz/3/Hl7efeKH?=
 =?us-ascii?Q?liGhr+FD6joBPl3hOslinqZD0ZWNsIsmYKjAyMVYH3m2RKsHHjbIKQJYtOrK?=
 =?us-ascii?Q?Fie7JbCvzbsJ1rIOovj+Np7UVQ1DTUIcdeLxPV0FsTpxyS0pAXod0d2GBhBC?=
 =?us-ascii?Q?I9vv+zktVo6p+Z2hM+cbjmHVgxKOMxVC83StXoHNIqJbodF1raHQcuuCSAR9?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee972902-6a54-4bbf-9da4-08dafff7719a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 23:45:45.6185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okwamARSbaCGiLz8955o0qX6STFuJ709qfPrH5dMiAiWI5o1tfGfEUfmFNpeqH0wLGOSjswGlHaKI8tTwqePWvH0BjlsjTS2ZgZ09ghvsFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6844
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 23.01.23 11:26:55, Alison Schofield wrote:
> > On Mon, Jan 23, 2023 at 01:32:55PM +0100, Robert Richter wrote:
> > > Hi Alison,
> > > 
> > > On 22.01.23 21:39:33, Alison Schofield wrote:
> > > > On Thu, Jan 19, 2023 at 02:04:50PM +0100, Robert Richter wrote:
> > > > > Only unsupported mailbox commands are reported in debug messages. A
> > > > > list of supported commands is useful too. Change debug messages to
> > > > > also report the opcodes of supported commands.
> > > > 
> > > > Hi Robert,
> > > > I wonder if you can get this info another way. When I try this 
> > > > loading cxl_test today, I get 99 new messages. Is this going to
> > > > create too much noise with debug kernels?
> > > 
> > > There are 26 commands supported by the driver, so I assume there are
> > > at least 4 cards in your system? To me the number of messages looks ok
> > > for a debug kernel. And, most kernels have dyndbg enabled allowing to
> > > enable only messages of interest? Esp. if card initialization fails
> > > there is no way to get this information from userland. The list of
> > > unsupported commands is of less use than the one for supported. That
> > > is the intention for the change.
> > 
> > cxl_walk_cel() job is to create the enabled_cmds list for the device.
> > How about we use that language in the message, like:
> > 
> > 		set_bit(cmd->info.id, cxlds->enabled_cmds);
> > -               dev_dbg(cxlds->dev, "Opcode 0x%04x supported by driver\n", opcode);
> > +               dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);
> > 
> > Because when we say, "Opcode 0x%04x supported by driver\n", that comes
> > with the assumption that the device supported it too. By saying
> > 'enabled', it's clear device and driver are aligned.
> 
> Yes, that message is more meaningful.
> 

Applied with this fixup.
