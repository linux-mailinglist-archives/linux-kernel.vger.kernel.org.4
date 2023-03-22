Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EF56C4F65
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjCVP0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCVP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:26:01 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF2461333
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EReBtrL9dWpx0hvGqCDaHbMvvj77vae0kA+y8g3vm33QFq1NdXC76njgddb87eTAw2kRbpR3eNRgngUEEWcNBZaYmcyn0+qR0YnuzIlMZ+Yp7z6MNOHGQeJ2DVjr/j+zfgKaWJopurZW2MkkY+QLMsGpsWbdzfxeaB+Tr1YLpuxOFSycPEgDI7TFPWJex0+45I3ORydBpKInz+Bv4Zb1Nx7WKVT/MQi7ULBNGgCSYJk6U3ujkOO12LJfFhTbGlYxBssRQYI7cPMpUTqoTr9zFZr4NvQP+1LJXvUWq57aDoYeReoadhp8WZTVWPFlJl6mQyIRVIOiFRkGy91hPC/+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFJ3YesztHquD0nm5em9+9Nu0IJw5d4pfg/EFpi9D8I=;
 b=AxvsR5oP6LNsSCVBoWbhV6DMhuKzHNSw3NAfRui448eq36P2PIcleA2CevhgZier1r5jRBaokMDkpxCbNXPToa9Hw5SgwWaiOlCQ9KEfzpx1tbvYGRvIJazcL7QVGBQ8lXXaQLc5Pfw/yaBiP5ZJl0iE0ytFvCE/Pd2j/XK8dyCS6WPx50C8akB/tRMp5mQbmX8ySuFG/wG1M1dgrqQp2ZZMIx9vWtSwj1SOxT8CrM68e8AwukdQKuR/YGqGMWtMz1I+99/0bMdmDLegorf1YzTuWige2yACBldPmLZZQTVP0oWOqJIVRHdzHOj6Zn14tNvuyGp/w02S9coNuQozIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFJ3YesztHquD0nm5em9+9Nu0IJw5d4pfg/EFpi9D8I=;
 b=meMWFjo+iWBM5gqgvD+vYAYMV4qGFb+rvYTTQIKmOe8UzDzz9zUhTa8dlzXhQkAXi+rpoeE46hvGsKZCpQ0q0I97vdFQBUg0n57i3RR8+jinKI8Wc0myshPWaTP1496P/tqnlwwrQmY3XTA/sVc2Om4pyu6ua1CMbF0NqWV+rHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8401.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 15:25:54 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:25:54 +0000
Date:   Wed, 22 Mar 2023 17:25:51 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v1 mfd] mfd: ocelot-spi: fix bulk read
Message-ID: <20230322152551.q5sjc62yu3ijp4wj@skbuf>
References: <20230322141130.2531256-1-colin.foster@in-advantage.com>
 <20230322141130.2531256-1-colin.foster@in-advantage.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322141130.2531256-1-colin.foster@in-advantage.com>
 <20230322141130.2531256-1-colin.foster@in-advantage.com>
X-ClientProxiedBy: AS4PR09CA0014.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: ce921e47-4124-441e-4f05-08db2ae9ba6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LcyjhlOVaSKwV5eLbrsrBICIayv/1Ymv5LHdFpjNJ6ybMrroRjaKFhYM91ivc/ecwyoORGlRtwn6f97RKbhErDSbTU0W6L7LHLieS+DiNSKYkPUPhbTJ92LvYC1Z4uSMXP0xNNyKAPIcv5FF6m5wbDpp+9gqtjR0VDmUEffJognoyMzv69Kq7ibWWHtIPqLKxlKAr29vML799hQF/C4M+6F/S701ChQJAoLhUCQN9IM3z/AzgftkHuRBGIaWfEfcK1HbvyOp61pBtPpkIO5oHlpOx9VH2c7t//nOzZb5WIY0wzCgNynnyUyFuFObKv/BqbzuQ+Vwhj8KWR/ZPp3aWSBhUjhH067A/M8Nws+lHAjwAlIj3oJq1rxRo7oFwKlsJMNv25kpBaxieiViW950fC9jBecjUv/cJyO3nkWjUeVSv8cQP28pWZlja1l/NnD/CRyfRY55oVy1tq6N9RekUa6CPFgAer0x73MdnjKuLfzXlGlQvslHWMWOTGV4J7D3zndBexnxAzNZE2TAeGiHMxkxg7DyTi25RXC2bjhOsv81CJbAaThrs1DBJELNiQk2fmvzi2Q0DDqCRZV59ScbVUFJoc5PuGQaRXf1D8JnATEvnibsv7ydpjpBAK+06k10DPjfKgEngKt5XSpSfUsDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199018)(186003)(1076003)(6666004)(6486002)(6506007)(9686003)(26005)(6512007)(33716001)(38100700002)(8936002)(4744005)(2906002)(478600001)(86362001)(83380400001)(316002)(44832011)(8676002)(66476007)(5660300002)(6916009)(4326008)(66556008)(41300700001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NFj9R5TKEPb5D13b6XgC9wY3QynJffchPFHBPcW96b2ZrjgQX5rFNKY2YGai?=
 =?us-ascii?Q?6wuSSiWTP/vTURBBXlc0n2dO0JRrZYyEh5DeiWOq52vgG0lerrHgvqjcNhdH?=
 =?us-ascii?Q?MBWSYBb9U2oFQ3zF6N2imlg0qS/dyIiXYA4B43d2Hs+cK4O0ZxHC1rIKSxfp?=
 =?us-ascii?Q?9zaKK0eCX2p7qBVoN/coG1OwZdQwdfvUAh0oKC2WONyHVRHyc0cdplBLC8jv?=
 =?us-ascii?Q?merOOBdFeFgrGecJBWHol5xfPvXJbeEdU8UwO16RM2w42wfQcHbcl57M0GG6?=
 =?us-ascii?Q?cP93evonZItbHuY/IQZfpmcc3G51dh77nPxw+1B9qS9rHAHpVkT1qk2HP2Cn?=
 =?us-ascii?Q?ekpxmuOpW6jcs8fzaXPCKlIZ1QmoVjoOsu9lbcyN8TtIPKr1VxpK5Yqia1FO?=
 =?us-ascii?Q?eGlvSKVnOMt3mIgNiAK3+r6EQ4S3eDCYMxThAt/WV/Cy676z0VCCXvata+1I?=
 =?us-ascii?Q?WdKt9he9luStDHgmhGfq4guS/lzQTfcdKD+MOqCgW9hbE2kMLKAb59TZfm2L?=
 =?us-ascii?Q?jmbKGg9mgP/YBxufMfshwo2tNnxk3qicLiM5GuX9D7PUMftRJ4ALoXHESnQd?=
 =?us-ascii?Q?oMdLUXUkyg/7rHmyebtpTU+S68L0Goct45H5QwQ7PpOwE+hAmnV5sF/l+UhU?=
 =?us-ascii?Q?xzqMfRcQLaLtY/o2H/Axk2cC2ve/ewhCFrsWUfstsLkOA8BXy7Uk8cXMle7S?=
 =?us-ascii?Q?FMyqARx/qZx+Q91uzamQ5tOQHPlMJtq93PsXx4ZUhrx/C0kDDNY2KoQD5wiy?=
 =?us-ascii?Q?2RnrSlUYnJJJd0KFUCHGsnQkBNblIO1LTxOZmRzagBN9TsztVfnJgLWpQ7g2?=
 =?us-ascii?Q?JLrP5fKfddiXd1/cQaxxMtYLNcmKBI0O3kPhNwj9DJq75Uplvf/njg3A4JuS?=
 =?us-ascii?Q?7U69EDOW80EdsHEc6ZQt3seKxmqJsXfahFkoKOiO8LRzPUMytifpqkdlh0pt?=
 =?us-ascii?Q?RgKbCD8gAkSDu2Hc5u9lUoFA7rz/c3Yyo98RFV6gTVScV6YX/Sxv0/nuJsgZ?=
 =?us-ascii?Q?dCMYxeJ3cFDQLFHgaIyhaiExx+LNMQ5icbKGKCoAdbgHrQfIblP7GmJ0fj7t?=
 =?us-ascii?Q?SDrZ/bLIKJf99P5mlRdFMxEX6G4g+veyYY3zistu98bmjugGuChDr9/lhtWR?=
 =?us-ascii?Q?M7LZbkCoHiFDXdCCTcI/hsKXKtVUDzXHpHa2jr4ETbcFGUe6BE1T3Dx66KRg?=
 =?us-ascii?Q?PrWqBR/Zq1uWjTBPgyqy8AWjsd8NsA4tIDCOnNMc4drrfbpuCGGpry5KNHr8?=
 =?us-ascii?Q?kidLHhHdLSqFDMfpraSah8MnbnGBnBZ7nKv2FXx+twW8SWsEMllVsb0kJm/i?=
 =?us-ascii?Q?lyuLN26FJZjUqlt2Gw+BEev0q01EsIop2rcO28BD9cGQzGXy9KGgiTSFdllK?=
 =?us-ascii?Q?enZU5busi/wAEyxwexCLJoGPP0OkJ2iW73vJ3UL/DyJkhu/T2j80Cy3GrTV5?=
 =?us-ascii?Q?wZZ8KHRIeVeU69UpI7X/mU5U6KgwAHJWdjj6WzxZInYnsZk3crmkyGYZbQhH?=
 =?us-ascii?Q?egpmMd2fCVZN0bBKQpMdYSbnU3b+n/DFpmEI2Z+uTrlZB+4Ittb9HnepjG4k?=
 =?us-ascii?Q?XKwvXayC5sYIikyNu+i5aCYFGVHiUpbM/f7xR7+I/u3J6BU1StI+FgglOpj6?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce921e47-4124-441e-4f05-08db2ae9ba6c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 15:25:54.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxzGSWIEeVCZmsGMxDXL2qc3QfG8X3/7izbDP2mQWRi2EEGnElSWenY/HJd/TQjsEfmUqnh12yh0bTJtCj7tDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8401
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 07:11:30AM -0700, Colin Foster wrote:
> Ocelot chips (VSC7511, VSC7512, VSC7513, VSC7514) don't support bulk read
> operations over SPI.
> 
> Many SPI buses have hardware that can optimize consecutive reads.
> Essentially an address is written to the chip, and if the SPI controller
> continues to toggle the clock, subsequent register values are reported.
> This can lead to significant optimizations, because the time between
> "address is written to the chip" and "chip starts to report data" can often
> take a fixed amount of time.
> 
> When support for Ocelot chips were added in commit f3e893626abe ("mfd:
> ocelot: Add support for the vsc7512 chip via spi") it was believed that
> this optimization was supported. However it is not.

Details? What about bulk reads is "not supported", and not supported by whom?
