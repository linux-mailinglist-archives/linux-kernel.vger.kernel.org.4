Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BDA6F876C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjEERTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjEERTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:19:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2125.outbound.protection.outlook.com [40.107.220.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8800E1A1CB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0UBRInyutMH+pqkLnPqMEYB3mDW7oZmlcBMuflp9Pa24YnLDMrTeyRXNPeu8LxI15Rz+W7r+ZmKpHF0P2zEtx2exUb4n43ZpfqNZ3T4+o9lq0BvKAvpBP6Y5+e/jnfF6/Qida8PD1SHOIdDh6zZqUIgNkb3NEHB8Jc9C7gO6Kpy87FRyJKJ8Na/PntFLkFYRJDQGvhkrWbISQwvLuvhx/FWX8ek5CCn4dNzih6ldnNt9LhnVAqEEucpy7P3ZPQ02qHxapMQ804ess2sIjGEU1Hf6nMlZS0wzalrhQWH3GqOyXlfLx9gZ5Rp/lIXBGyZu7W8i4XvYWgUcaD6TMz2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiuQVeMoikqqjQQIgO1aWvkAzpMmjM8sw+WwLOfePnA=;
 b=fNhiN1xXZSA1pcrto/R/Z9TKIMZdrvpNjqPYASxfKf3KCdEKvGYhbY9w3fkXtu0AqER/u6o69akVXI9qwdJ7+eDdzJihviu4xjNTNkC4LHHuq0AE7EwAgOHafXZHZF0M7X/Ir95leO3GE+Mq6mMHBtpZpDcfKRWUeRzH0FDIEuTAU2A2YD+1aYG5I6wP1F76bhKUq7lbTNM2BkOG0ZpvpUGvbxvzS5NCQyE8ZtAeoTVa+zGHi9NuvLO7+isB1ivBygpQvNNXEs0CFbS0Y8MnZ+GYkdM5bil/A8tXJYlsnCN2gpPEUIh20NryfvaoF4nDElYIKml5JKMFUH0PLGGpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiuQVeMoikqqjQQIgO1aWvkAzpMmjM8sw+WwLOfePnA=;
 b=ZYKbw1SXHW0fNXt4vc30O0I/Ztzep9rH0UMi+hIc89Enew0Z/TPWzoeqPcsGK27gvCNRhwMUrc2h9naL8XNlyxkNmg3uQw2LI+TRBc1CcGSZa/TefNSMNT6G6pb2+3iOZ24gAn0lwXP785Amug5V+l1VvwrE0QRxfE31FWx3JS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CY8PR10MB7217.namprd10.prod.outlook.com
 (2603:10b6:930:71::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 17:19:33 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::3fcd:b2d:f7d8:6fb1]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::3fcd:b2d:f7d8:6fb1%5]) with mapi id 15.20.6340.021; Fri, 5 May 2023
 17:19:32 +0000
Date:   Fri, 5 May 2023 10:19:29 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com
Subject: Re: [PATCH] regmap: don't check for alignment when using reg_shift
Message-ID: <ZFU6oepWPoYDJczo@euler>
References: <20230420150617.381922-1-maxime.chevallier@bootlin.com>
 <ZEKwxhJJNkuX7VTr@colin-ia-desktop>
 <bb836be3-456c-48fd-9b19-62279fee6b8d@sirena.org.uk>
 <20230428093010.07e61080@pc-7.home>
 <20230428094745.63677228@pc-7.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428094745.63677228@pc-7.home>
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CY8PR10MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: abe37dbc-9aa6-4409-d734-08db4d8ce444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSJhsBVa/EE8NAMlPh/39L+iOsvP//EKRQTksoZLP8k+h+/aQ90R/imKV2MMXrlw5ZJ6YSb0+nMpBh6Q692umQVKXrU8LJq1qv8Ev3Gpzh7nJStEtThEvG2ZEMkSBvgCBe49bBob78OciSVz2eDozhM4ZMr4KlGa8Lfz14hzhu1Sci0DFhBefCCJyLYRmfyvLGVs32BX2Cpp+2vtps8uuRBOleNXqme88JC0R2Y1ky49GpaYSmLVGg0z2FmbnaGJc9tTLG7EE9lBD+sHDLvTxU4Fv8rmITNViXW7s4fhK/4cIE1nDc/JlFl5Lbal3cOef6rt/rIGgbUtcRP7XS8IBsk6xP6S6YbSg7pMF1g6kdFmNSnYte8b5zAcGF+GjXryAVkeKDgMVB0NKkCmsbKjX3u6lSpdpbxJ+PGR6XTTzzYWgG3jVLlBSDUKkKSWoeiwhLYAouEaafKL8/olz35PesuqThVVDQCTq1TaXsf9uoVTIVdWPW6Wi5GF1EozvyTT/tdntx/qZ6T3FYC3waYdfzzo4r4Wg++ENqW62/ouWJ8nOwy4vkJxNJqYbF3pa/0O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(136003)(346002)(39840400004)(366004)(451199021)(38100700002)(186003)(2906002)(54906003)(6506007)(5660300002)(6512007)(66899021)(8676002)(478600001)(9686003)(8936002)(26005)(6486002)(44832011)(66476007)(66946007)(33716001)(66556008)(6666004)(86362001)(41300700001)(6916009)(83380400001)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d++YK+JzZOCY8wSMdIYI4kkJqbDsSnLQun/+GW5WwgCGDB04UDfdRuo746dN?=
 =?us-ascii?Q?TSV02wrrYswjVu46n1j5c81Jy9Xif03xdYjTKVag2rB3VjpSG09VQzKYJEqs?=
 =?us-ascii?Q?SXmovflo3naL3K83lPoGCN7GKxpijzITvxy1l4EdkV0j85xO5W1rfDw2bMVN?=
 =?us-ascii?Q?3gRBWBPYmxBNt+t/UzcLiAXJaJ1G20P6YnkG2z17Py7UVKhhhsBbUdTthMlR?=
 =?us-ascii?Q?t5yjOnDVqXyM/T1WTSlAs6s4ph0sDga4uHUyqGUTenyyfXoQa2roRkN/q8oM?=
 =?us-ascii?Q?vIFX6xU/cuGtK0c1NhwBSOfiHz1T4qE12CdsHRkILFJZrOm5RbzbTFGLi5Ut?=
 =?us-ascii?Q?W3vYveZcLuuxZ1TI7FXz34l/FAtrWjrp2cOn6TREetWn4QmTHn3vjxw+HPLm?=
 =?us-ascii?Q?VycbbqztOFNcfCUoUG/XmWJDz3TeDoKayudC/sCBRSJ7yCXJxn9SZeW2YOqI?=
 =?us-ascii?Q?MZG5y2NzieADisEXClDA0npEsrFA5RU1EdyKTH6xHP9mJqmNEjFPBAK4SGxt?=
 =?us-ascii?Q?TIhgHHMbw9s9uFJMKl9v+FHBPARkTpaiy/YY6fON8csvrkWZSrvQEeXOI4f5?=
 =?us-ascii?Q?J6HWYzwUSAmwq8ZOssdJ1fV6LSiY1bNVZ7qYEQoxJBQV+MCb2G8zstbxWkrn?=
 =?us-ascii?Q?2QB83clScPLVGHQEeqxyJ98iOiN8hXNYwSnrgSOmCCnpjXPL1sjgKExL6OBB?=
 =?us-ascii?Q?NC28g90vWwOX/to7IawSH4GnOyJgnINbmR7ND8JKaRoCvdbM6fig1WV5blYP?=
 =?us-ascii?Q?53kkLKS/KT12GXxhEO5qC3YA5Q+iPLnl6qfj1rPL500bVZ3DO3zxKmIn/yQr?=
 =?us-ascii?Q?uy0qqdA7v+FNY4y6uwsRu+VaOx5fShzY+ipvkuXZH6fWx1VlvWezULHuxpKd?=
 =?us-ascii?Q?0m6PG2ohJT3CtvKtxh/2+fXVX0d08InIuFCJbEDpbn4BPYXgGQvBfw838CZi?=
 =?us-ascii?Q?+X6GA5agLomuHxRmoEwL/fDkCMr9z9w4Ksfav7q3uZTydRauCJ2zXL5GHCk4?=
 =?us-ascii?Q?Kclr5YfTIQJj9aiqZy193rvg/tyP0DJyxeMXS/VoaJt5N1zIkJiZqWF6zPMg?=
 =?us-ascii?Q?WEj5z/Vjt+vOR3z2+otDtiGMpgGdx0CPSo+3sfn7keoJFb+KSLbsuPVJ2VdV?=
 =?us-ascii?Q?MqT0+dFvdWRips90gZmYmH1DknT8kyIIqmejZvVqpc5ee5f1f0LAQlU/PbxN?=
 =?us-ascii?Q?CGSS/NqKIY/+Xg7qfhInhSpPzMzvCAQj94sh4AU5LH7c0nOi01cKiRZzk5e2?=
 =?us-ascii?Q?WHZTuyLunz5bOZb6tYHT7CpBFgW7Sb9zjh3z1BW7kOcxBG+HFYpV5bi/svA1?=
 =?us-ascii?Q?jyY2519+sEvEHkwvNDmEZdcVVnGtB7HwWN9/kZC2ZYFWkBDOrY/V0mmktprx?=
 =?us-ascii?Q?YNrCkddc0TyYVAE1saB7HHuOEmYNlzVr9YxzQ2LwpmvrYIFbzZevavq+aHzn?=
 =?us-ascii?Q?bQuiuPxm9mLyIBmVDKTjx65dNgczZMRqSr4p1WvOjod1g+cKdbPRuVH0n4pt?=
 =?us-ascii?Q?JosjdwVNY2Pwb6QwZOWHnMwtc3nT6qORNxe3cvc3EAGwE91CBm+Z902SEvhu?=
 =?us-ascii?Q?Sw2qjit2LM3Bb9EQepMIfN88N/IFXykYqKt9u7w1mTalaBOlqjefnkcfHqZE?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe37dbc-9aa6-4409-d734-08db4d8ce444
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:19:32.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvakP1Ze8F/I4Q4bWHalc+3MaYuqDUgrD1CprVKGi9fhiImQe5GNgHKVoZxLuTW8K5HXtJUwtl4wzq8FHq/F8LZ2NBLXdcNYlgXX/jGI5is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7217
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Fri, Apr 28, 2023 at 09:47:45AM +0200, Maxime Chevallier wrote:
> On Fri, 28 Apr 2023 09:30:10 +0200
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
> > Hello Mark, Colin,
> > 
> > On Tue, 25 Apr 2023 13:56:23 +0100
> > Mark Brown <broonie@kernel.org> wrote:
> > 
> > > On Fri, Apr 21, 2023 at 08:50:30AM -0700, Colin Foster wrote:  
> > > > On Thu, Apr 20, 2023 at 05:06:17PM +0200, Maxime Chevallier
> > > > wrote:    
> > >   
> > > > > On regmap consumers that require address translation through
> > > > > up/downshifting, the alignment check in the regmap core doesn't
> > > > > take the translation into account. This doesn't matter when
> > > > > downshifting the register address, as any address that fits a
> > > > > given alignment requirement will still meet it when downshifted
> > > > > (a 4-byte aligned address will always also be 2-bytes aligned
> > > > > for example).    
> > >   
> > > > > However, when upshifting, this check causes spurious errors, as
> > > > > it occurs before the upshifting.    
> > >   

Sorry for a really delayed response, but I just got back around to
thinking about this. Crazy busy times for me.

What about an explicit parameter in regmap_config that will disable
alignment checks? That seems like it might be a welcome feature
addition.


Colin Foster

