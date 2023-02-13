Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5E693B99
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBMBHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjBMBHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:07:52 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DDA4EDC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:07:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOsMTQcYHAIAsZ4lNIVwnoM99bUC/Mh7KE+ykNeDsIK7ylXC8ZX8WsjPZDTTuxIy+OkLwPzoTWYGmtCgWzm+2thu4Wsw04jGeNXvq4JzjzQPC2IgzwNnBBvqznFEa9R9Ktg06WQWvUFfkIPjhWkJDnZkpYzUbdsHz7CzvdsUdZ2BcLKA/68yXqNIpD1cDLOdGujyl6M8/7HqKaxFUlPmto0AWEo3qpcsVhGLO0YLyVy8Jql/FnAeNlOl/PzHcd3q+i0hsBhW4+LzIsD/po5Hq7BV7zXrkLCJkOrteSe9st4IjBHllzriQNyXPzPSlbHWGYEiBrd1F4xDwf0lpbHXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzDzmlv8FWJa8GEM4AUc9E2G111zbIl4+auldccfdZ0=;
 b=hMd/IlvP9QPuyFEw2ONdMYzvO/L9oH2NmQ6ClVhYKRDejc+TT/jqlamayahwnd7j903u3WZ99aOwIF4zZAzJUnEontRKGlr7W5Bd0moQdJK9oMuV4R/OFUjMjymV7fBojrKzJedI7uNFrHbEqs1S3x70lZaEWDurwAStyMvxvqwdQf2BYAuKXv/0drRrxrKHDU6kHlNOev5D4U+JOo39kwfurqcC89KlYeJBMZ9/nJodXbJ90KwCdxtKn1a2l46caFt9SUgJ0nhI8htDHN/cqGzl3gvTUX2M62x3Is5vM9MN2Tp4BqwzdoWFP8ZAH6AWFeEpsRvxezhTnyjhPDp/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzDzmlv8FWJa8GEM4AUc9E2G111zbIl4+auldccfdZ0=;
 b=i12/TiyBsyhXz8rU8vF1QHD9eC6+F6R0NL1OWMYeMc6wLOQUz78QFodVbXZeCYJ+GjZXcKfjukzIaa5D0BzS0UDkVlBgEVSoTPkAcsZrtcKAO2FhgTWsSAU/4Sf/IPDFOD94XoENM0ice4NAICHJNLCno1864r00WwhlA/M+9V4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3430.namprd21.prod.outlook.com (2603:10b6:8:91::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.0; Mon, 13 Feb 2023 01:07:48 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf%8]) with mapi id 15.20.6111.007; Mon, 13 Feb 2023
 01:07:48 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Thread-Topic: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Thread-Index: AQHZPFdKu6v3b+HaGE2yB6PHNlodO67LulNA
Date:   Mon, 13 Feb 2023 01:07:47 +0000
Message-ID: <BYAPR21MB168857905915E00B29BAFC7ED7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com>
In-Reply-To: <20230209072220.6836-3-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=93d2beb3-0f9d-4c98-ac9a-649b9e377a8e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-12T19:37:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3430:EE_
x-ms-office365-filtering-correlation-id: 0832fcda-7dcf-4a52-91da-08db0d5eb898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RkU5JrpVigvZs6hfnONbEoV0HM6bgV5fGb6jdDdhokRArtp4Q2CNPE0pO1v5RXbmkgUXW3KdHboXsGb9VathVx+3yWnLEr/jwm4ozes5yj045phtbLGgzhHVjIpiKjglBHvI+r/WCohGS/hTxlFUO1aXiQKQAVuWipeocFknlfiub4rg0kHruvJFi3FVG0CCjJAKpVhdHfouNUoA/KJu2ExgyV4bb/GW/M8lwypoOJYxAMOcDz0myL14n40A59iirB68U2spdrKQpfG7jU/inxhQR1553v7yUBF8ZFiBK9ubEGrkwjG07TRx0Z/3N3nS2iYRP+JI22m5jR+ACz/Hzp0slU9YdA7gLPyMkYBf2qFrYYIqkh4BVWLWj6CIYUXdFQYq/JvGUJ5NS62eYuoT+4HVjbdNoDNueR3irmTduT8vYa8NtbYIDVvn3IFhSqUCRjNsOHyqWviFBl+zVFF2Hff7CfW5NwRBNUTjJ6XVWpQBZycfk9bvINR/Sy/KOVuHo2/s5Ot0RDVOmo7btSLPNTLFmomjy3zcF5yc1g+JAYwF3XqQPisg8nsH1Of4hEAFBFNVp0rwCmWvUumPysPNW5R+lffA0Yt32rPJzXjFTeO4KDJB5wT68BalwwFN6RLzIx42Kollf4orbYagMzRxRihAlfIBJK12qH+dlUrZFL0Stx7z2+/Hq01Nn53/F8gRksZHtnzwE1Y03m7/7c2FGN6QzmabEr3L2/Sh5WsOp7WsD32bAC4IKs2mz+LKfYIb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199018)(52536014)(38100700002)(38070700005)(82960400001)(82950400001)(122000001)(33656002)(86362001)(83380400001)(186003)(9686003)(6506007)(71200400001)(110136005)(2906002)(8990500004)(10290500003)(478600001)(4326008)(66476007)(64756008)(66446008)(76116006)(7696005)(8676002)(66946007)(66556008)(7416002)(5660300002)(41300700001)(8936002)(54906003)(316002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pt7K8fQNj7zXNP5UM7o9UPfTcNrGiIADdLzkxCExV3Go5HD8helYank1bqyk?=
 =?us-ascii?Q?7wLg4TSdISJ1Acp0RenkSevv9Vscd146Ta5zITTki5QhBEGa7lIY2qe3z4y6?=
 =?us-ascii?Q?zuGswclYyb3Bql9sAzzBoYBoM2kC7H+okpy6ISDT5aRrgMbsDZwBfhmRiDd3?=
 =?us-ascii?Q?p6csxkkavgAlqDSyzEll1K02trY0D7PW5mUTcOEnSsVKyq4EjWW76PktHti0?=
 =?us-ascii?Q?c7FtjuJnp8X+huG0iazCTacIq7SUhFd+3QZZHptcZW3NDF9wzoLZecFi+BlZ?=
 =?us-ascii?Q?0ob6HYXO5C6O1WHMP6enHE3qe2xRzw26VBBPzNmI2ScW+V7aYvBDbfWo/+j8?=
 =?us-ascii?Q?XPvrXDHfkLQX7XBzVoFhZSpQSkcFmjY9BmJnkf0laPTrQGzXcr97Kkier7B3?=
 =?us-ascii?Q?B2RfSm3FlWKCLet9MStlsqm9dc+uVNarrFdkmvhZjxhMnCE+9eclsNZ4r20j?=
 =?us-ascii?Q?cQqMzxCcuUD0fpuya7UEgtKHBWL+MnbnNp96tFMV5g5dtf2rpz9ci7f5A1Uz?=
 =?us-ascii?Q?4SL2wUE/wfB8BVQ5A6EAH/86ISNBEy6m5rtTGfONpwcV1lRRtrCT6XCCsAoB?=
 =?us-ascii?Q?v9A+3HGoa+Y8+vdkt1TwTy26xPjKVq9Y4/9RoGD4fX/PuFArAlJS5J70v8Ah?=
 =?us-ascii?Q?k/DgrWqPYuyz1fJUjK4BKZSW74pj6q575cYETm03oVsnkfIxkxxNpUYbAmu4?=
 =?us-ascii?Q?yh8oIIjvZ/58dILp+xwsHqUoJF06QA1++B8o/p1Fulvi3urqTPZw/VdjkXS+?=
 =?us-ascii?Q?DSx/ONq2KmBEZoXvcupMd/bsQWeH2GXFPeTWe2CdsEGn1l9LDp0G/bYo0ixk?=
 =?us-ascii?Q?kj1zmy5ZH7DgLbytXQkbp+8PCBGhe3ySsVsNAAdKQnhcKxWwiZSUtH2ErC8Q?=
 =?us-ascii?Q?VHf8RvbrlgxeBHgrwt5oUf0WpbBBuKsZKLv4hr0iHZ73spofPhnMTaiQePR1?=
 =?us-ascii?Q?oFonSHSIbqj0zUu/agZ2phCuj1QeyjmETvBRiRKqJLsf0CULCw0DAdFDQVHM?=
 =?us-ascii?Q?c7CYkOOS8nTaan+l7W6M5AegZr0MND2v8uLX6KHJjWGhW4CY8zqHyM0VFfFG?=
 =?us-ascii?Q?YfIRoOh4ISagtArCRf9Pu4ykj7VuahgR3LMilBgrMNTpKRooQIW89LVl4DXp?=
 =?us-ascii?Q?nuxYHvQIJcnYW/TrLIzN3hRZomuFxK0kngMkrlT4stMTx4fOiC15iL632lw1?=
 =?us-ascii?Q?yDmuyAWVZ1/1eipyPL8dRRMJuRbE9XnjxiKEKjoT/raVHD3wahlufWKd6nny?=
 =?us-ascii?Q?xGypXhnwZQ9tdIQtnMCE6MrUvNF5NcpjE4ib5SJhi1/318uZkGoiqlCpdU9J?=
 =?us-ascii?Q?XBQVeqpnDSIZFI1Oqm44sig/YxOaxtrT/Shcf8SbNWchG4ZVqLBAVgBS8eKH?=
 =?us-ascii?Q?xA9xIs5wVUKWu8dhpVBwoS8eNo7EO2WP9lWD3/s9RQVPCaMVvmIKBeKlEUbo?=
 =?us-ascii?Q?/qnx5zmlTNwh2SA7haZN48+2LRYtOGm1aAS3fQnlF61k/sjbTWrcpJxRHx/q?=
 =?us-ascii?Q?SNt3iRKAD+e4fOLlAg0qkJBph0A9zuZummU7V7uDHHfdvCDR8zfBQXILl8tc?=
 =?us-ascii?Q?d5wy4CLR4RMkYLbVjIdZAB/PuNL+785KvAHbQbIhfhOdOTRf6ZE3APRk+fNI?=
 =?us-ascii?Q?bVUtUfG5nXfW91iv9dUy5oawyiST/qYvDfjXhxAlIDyXS8X2TJI6b/oAXd7y?=
 =?us-ascii?Q?mnhCmg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0832fcda-7dcf-4a52-91da-08db0d5eb898
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 01:07:47.7838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hx5sRMBGxEaDBqpJUoO00FxoXx3PW6/HnQZw7U/ISZLKbMiUNEFllZm6UXMdwt0pGXTj/ontUP0W2g2s6wJVZCLAsUpVbpGPK/KdtRpPMig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3430
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Wednesday, February 8, 2023 11:=
22 PM
>=20
> When running virtualized, MTRR access can be reduced (e.g. in Xen PV
> guests or when running as a SEV-SNP guest under Hyper-V). Typically
> the hypervisor will reset the MTRR feature in cpuid data, resulting
> in no MTRR memory type information being available for the kernel.
>=20
> This has turned out to result in problems:
>=20
> - Hyper-V SEV-SNP guests using uncached mappings where they shouldn't
> - Xen PV dom0 mapping memory as WB which should be UC- instead
>=20
> Solve those problems by supporting to set a fixed MTRR state,
> overwriting the empty state used today. In case such a state has been
> set, don't call get_mtrr_state() in mtrr_bp_init(). The set state
> will only be used by mtrr_type_lookup(), as in all other cases
> mtrr_enabled() is being checked, which will return false. Accept the
> overwrite call only in case of MTRRs being disabled in cpuid.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - new patch
> ---
>  arch/x86/include/asm/mtrr.h        |  2 ++
>  arch/x86/kernel/cpu/mtrr/generic.c | 38 ++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/mtrr/mtrr.c    |  9 +++++++
>  3 files changed, 49 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
> index f0eeaf6e5f5f..0b8f51d683dc 100644
> --- a/arch/x86/include/asm/mtrr.h
> +++ b/arch/x86/include/asm/mtrr.h
> @@ -31,6 +31,8 @@
>   */
>  # ifdef CONFIG_MTRR
>  void mtrr_bp_init(void);
> +void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_v=
ar,
> +			  mtrr_type *fixed, mtrr_type def_type);

Could you add a stub for the !CONFIG_MTRR case?  Then the
#ifdef CONFIG_MTRR could be removed in Patch 3 of this series.

Michael

