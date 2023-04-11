Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F36F6DDD15
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjDKOAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjDKN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:59:51 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021021.outbound.protection.outlook.com [52.101.57.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2124EDA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9aYre/Xu9hxMSmu56zsHesif7+W1iA5Y1jguaTBuZeNjAZphL55PTpRJ2Lm6nDDbFivFNmOuAtCQ/CM6YZjpTwxR7Y3U18hH6/iUCmSQlp+m2RrxkllnlI1LAeuVDQxwvcK4m+jjH2J6Ko7HKvEw0p6fS/+199wWVhgJfZV407jUwYAmkyUYa4Q24IWX5Ob0Vkajq0BjH4fTalTkCkR+Vuk+GuT4RmAuITGMdIzWOi6O/UhI79g9Q68ZHc8r+3VDyf6bWzXFCtIZb/1P/CmqoHYl9JCBslQht/LSHVdgcx6ZTVhsz590l9ovF0LCvdZecWlmJ2y+oq7lTWjSs7W/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD+c1G2iBBNNAs54qRg7DWtZnJCizDxXxN82Ql4bCr8=;
 b=M09/XZRHKBwAtwvOyNwAPJbdZOOg6UkcsNc2iWoNhIub+pluHUjRWMWLpU4r+Vl3kjWn59xr1XJb2qvW0YIXPt/XAQ9hfQ/wxAdO3ofJOtbNLE2rOyKYbrIKZ6W4ZltGDP1Lf1BUbN1v8boqwv9//4zWAs8+PYDyUqbsDpi3ua3b7se3yCN+P+QyG0NLW4LnIojqPF7VaVVFfYbtwXmtvGjETVapUiSb3xpHws4+U7Kfv2hMViGgHy3PBph6y1/Rtr9cYI7hGvW79A13bcWVopUEx3ycG8m+F5n6mrPWWunofPFnJGAYfF8sNHSBQ3LrxhU+26d0b+0DqWuAJqLLAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD+c1G2iBBNNAs54qRg7DWtZnJCizDxXxN82Ql4bCr8=;
 b=INYgIyQ5rd0DQx/Nlkktc2EnGTikLLbl49WbS7IwtMe2KsbUXqyA7h6oL/ahsWfxFUs9oikEGDTFDLxvMtSnCbY/ThTS5X2ti7jGLFBgX2YIbkIn90aPBWEOL5nb/BiP5yeN+uXK7pKa4MWx/8fnoppP7etY4L4mFwG5gDnJAB0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3041.namprd21.prod.outlook.com (2603:10b6:208:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.3; Tue, 11 Apr
 2023 13:59:36 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.003; Tue, 11 Apr 2023
 13:59:36 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Topic: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Index: AQHZZGRqmwfNjKNQZkqeuaz4fZnI+68mKAkAgAAHNiA=
Date:   Tue, 11 Apr 2023 13:59:36 +0000
Message-ID: <BYAPR21MB168853F1DD1B76FACC1CFFFBD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
In-Reply-To: <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cc75cde6-f895-40d2-b39d-60cf64fcd960;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T13:46:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3041:EE_
x-ms-office365-filtering-correlation-id: d22a9591-cc4c-4a18-70b3-08db3a94fc5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SayBvRyHSfNIiW7N//36yFjQ519NksnAM2sqQqs8R/DBTYRiUJojFhoHTL+ANWvKIpYggjY/ZFIq2LPRkierO+xW0rgXp+2OkFhTXKJNzfuHJgck8HdGRuqW7+c+UsgAt4pkKtecmVrd8t7HOmkHFR8Ug3OXK6BD5J94aZUCbozQFSLy8/VtEDyKhu1YFO2/YUWf9GghU1DBXI6voJNRgQZUpbKNssDKB9/iyaC4s0wtKn/4cwoA6C8ElD4H7ab0qfABC9n2rEM61i1WGSCNiLmf501huDiMnGovbvwAfUdUr4vEFQtmI1J4VTxVwjQJvNrv9iWUAIWvvo+08Gqc1DpvAQ3kUk9QxESX/uEHjDxFw9KUcEQzVvIwOdu26VuAJhON6J5OS/X331RnAkjPl4CrttLQPCjTYBT5FKsuFPeBOCiNQ/hlOJaeSUq4vBfSv4dvrHkLNJGc0S+YoIsfc9QUdfDztL1nHTJn+xH72f9VQMv9UaA6XCIz3II0s+8cAygIKymVOK6zh3LcFgW+9O9STvesFgAQZHYIFt/fgI94IG3XDgATbC2U+/agWnKdBF3GRMpoRWag4ZJ/6fbKrquUOJD+qsAfURrEQqTFX5uaphn9dq9bnJPpvLED5EaDl6zKZ94gYc+5t3KkbShK8KisD6Yhou2ULGW/nkfc9+U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(8936002)(52536014)(86362001)(66556008)(66446008)(66946007)(4326008)(66476007)(8676002)(7696005)(8990500004)(33656002)(10290500003)(71200400001)(122000001)(38100700002)(82960400001)(478600001)(82950400001)(64756008)(54906003)(786003)(38070700005)(110136005)(316002)(83380400001)(41300700001)(55016003)(76116006)(186003)(9686003)(2906002)(6506007)(26005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IB1a8OK6i72Zq6dCAHZ8w4OPVie22xlX4M4G7eFxbx+xbavsPnLSUy6cbogM?=
 =?us-ascii?Q?9r18bklyqdstSTGGmjEkoEwgvq3WQqVfLzJBPSWRj0U7PSyzJ94K1bRrVgn8?=
 =?us-ascii?Q?3OfnVEm+f/ANkqpW4+gbXb6Ts1VzKAsbUq5UzSlDxzWW7UabrOjc3SnYs2Ov?=
 =?us-ascii?Q?fOOtT5OhhgA2WcGckcENEULrEx3qE5ZM7UWGUmbHXeBZZVXRgsxkRLHwhHTo?=
 =?us-ascii?Q?LOBzofXG2p+rxSWDWx8Jb3QXiF7pCMiN6efAbRu7vhc/bioIqhhXJ2rbGFo+?=
 =?us-ascii?Q?QOhtwuIl+/B7qlWAOkImTIpt3h5gIEwEqQsiViB9w9LbBirz2KCzyP9yrQB4?=
 =?us-ascii?Q?i+7fw4QHEUKKJhF7Ji3FcvO/FBaaxo0ij7V6CWMNJaYdTYpG1G1H3UkzbA5M?=
 =?us-ascii?Q?bmyjS8En/rUPQVr9G43h6rxwFutGu8/LF+DWCCMyf1QHxL0OiRGfTeLnejGt?=
 =?us-ascii?Q?dps9tcJW48pVO7jiWgNgzy7i6ZrP3aF7rVXpkycsGk2SPcLfRNaEed6ffb5V?=
 =?us-ascii?Q?2R6lwHVWjiOxGDA/f0S9+I/lOY7hVBYT2XxLJNu9aOrKCrRYTq9xDYaVTDC4?=
 =?us-ascii?Q?tqcDCqS0VhKIzmYil3HNtSDYCHArxfaKe4G2p+HVKamCfAX/l2BeZFz8JihG?=
 =?us-ascii?Q?i1LTnUweC4Ft5ERQGYJswMEtaaOlefWeZl3CU07InlwlDs+lMfrmg8d+K6Ro?=
 =?us-ascii?Q?D19ztsnNHvU+0rf4dHYd4rHDoGItWD3cPiGO1wleahke1S0p/Q+AGTcFy+I9?=
 =?us-ascii?Q?9+QL+NIuzYPr/Fxc/sBVD8x5AEWeuH0akiSqSDK+9FDt10BzFLOOwr2LI40a?=
 =?us-ascii?Q?5dmDDH0cIuJ74uJeKrliVkhvDzaymSaB6kFvY6D/dGNJQFrl8Rnx+WohPqMF?=
 =?us-ascii?Q?HXrRP4VHLZLneWLG6rzEPaQ4iwakrLG9l1yfXvZOnJKpw815RkmetoOjs8eK?=
 =?us-ascii?Q?sQiTmHI/0jOGmqkOppkxs7gi2wm2jE7SG5LC9y6iZ61lmEf5ki76wg++Kt6Z?=
 =?us-ascii?Q?hw/GtzFQ7z1EX1eeh62YvZVy+S7Ex8V9xnDDaXmWkCCTGW05u9cN9Idz3iui?=
 =?us-ascii?Q?vI42M4wciNcSWu2wuLdK8bRENT4VoOgPin0+k/xc8Uv1mlbGbxvwk6iv8Ez1?=
 =?us-ascii?Q?usQM8xaH5eCyaJGIofUQjfCHjDNhEauI2y82jBT5UcREXuCibZcVUJKmUPFF?=
 =?us-ascii?Q?oav3LBAD0Paux9hTkj1XB/QI5+blzhsk0xbPwbGNtuUAu4vsRaJq5rIpIa5q?=
 =?us-ascii?Q?EMF4ApAkr7CNs8qL+pBbrnfHcz7gPrSFS3Vur871UBE14NXSz43xzv8gwo1l?=
 =?us-ascii?Q?RYSXr9Y1n/sxwO9uID0LT0F7FIF2jLOiCmmeh4fd/QNMJ7r5j13j6UGg5wC7?=
 =?us-ascii?Q?sbfE6ZD/yduPNLaUIlk1+jvQTq9+mA+apVgwFDEuOJJLZOgYTkpUBoWaPD7C?=
 =?us-ascii?Q?ckjP5m0gCbK0749ciX+vtDrBgrsMrYNR/jOnvkOVkgdJiYIFWYCRq3bbPWF1?=
 =?us-ascii?Q?p04hSnXuI3iLIetEtkDHpUnwbrd7rjCuZbtIpaFkN5EO0r85Qno4NdSd3bV7?=
 =?us-ascii?Q?E4bxJfw0K6WZeik1FWnnLomU2kRCLbSFfUabveVJJEn8kvHepknbkc+er4nZ?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22a9591-cc4c-4a18-70b3-08db3a94fc5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 13:59:36.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8lhFYvMbaImv3ZWWTrgzcCgY6tB+egUPgh8GLOuV+MbiFgEb2HMXaX2w9csXmC+5ji5goowXAZZ6g1VW9wtcRG9hW8qGpVcrFcP03C+zuuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3041
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@alien8.de> Sent: Tuesday, April 11, 2023 6:21 AM
>=20
> On Sat, Apr 01, 2023 at 08:36:41AM +0200, Juergen Gross wrote:

[snip]

> >
> > +
> > +	/*
> > +	 * Only allowed for special virtualization cases:
> > +	 * - when running as SEV-SNP guest
> > +	 * - when running as Hyper-V isolated guest
>=20
> 	when running as a SEV-SNP guest on a HyperV with vTOM enabled
>=20
> that's a single condition.
>=20
> > +	 * - when running as Xen PV guest
> > +	 * - when running as TSX guest
> > +	 */
> > +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
> > +	    !hv_is_isolation_supported() &&
> > +	    !cpu_feature_enabled(X86_FEATURE_XENPV) &&
> > +	    !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>=20
> IOW:
>=20
> 	if (!(hv_is_isolation_supported() && cc_platform_has(CC_ATTR_GUEST_SEV_S=
NP)) &&
> 	    !cpu_feature_enabled(X86_FEATURE_XENPV) &&
> 	    !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>=20

That's doesn't work.  Hyper-V guests with vTOM don't have
CC_ATTR_GUEST_SEV_SNP.   As previously discussed, the SEV-SNP
machinery is handled by the paravisor, and the Linux guest doesn't
see it.  Enabling CC_ATTR_GUEST_SEV_SNP in a vTOM guest would
trigger Linux to do a bunch of SNP stuff that the paravisor has already
done and would break things.   The standalone hv_is_isolation_supported()
test is sufficient to detect this case.

I really wanted to avoid calls to hv_is_isolation_supported() outside
of Hyper-V specific code in the kernel.  The alternative is to create
another CC_ATTR_ value that is set in the vTOM case, but that reopens
the naming can-of-worms.

Michael
