Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8CD5B454A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIJItJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 04:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIJItH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 04:49:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2117.outbound.protection.outlook.com [40.107.243.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB916746C;
        Sat, 10 Sep 2022 01:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReZcp6Go+0AYRvQ6LjJswHY3S7g/3l8yf2vxNNyZ7u+WMnYL8gPwaPJUbHxO8ojRD9snLrTWgIj82vapCxaM8AJbsZ7WK1EtXiVo/gIYbnfN5vgNkkVs9Xg2AJYaxP7vYq7iy+OflHdui5Rp7L56RLfOrX6OkLGiZ3bTrEp+qnodgzHlDcRsXNJJQdFSGqqvkYYY4h/kO0lUEXSXgAZrvpD+kBS7yuWeHwsc93QC+6tcs0AA0XSGIebm4vELJyhAnSRaR3BzkpJklXznXDnZcmdiwe9G5clZFlaXuVm/fMq8dlJE+MldkYWIoPBtHkDom/GfoJBc6exQuEXcnew4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTUPxfUcBoOidsF87JZPLzEdMSM+1YMC/594JQbXxUw=;
 b=aZrhBmktjVmw5PEl4hhXpQu3YcFOaf2/3QvH9axTre7qu1wChZK3C07qqbp9P7ULehIOgJUlCCmyIMvKWXaI51y5dPo9y5C3ODveFUzUBS1bJwZpOR6/wt5HQBwfHywhlp0kbChTBR11yOmKvAhuj/gfsdM2q3VNoYA1f751zYZk9MMEJoKnu0M3MMq+rufD7kpVebSmvh5mnM6extQr4lRgksCnCNtU4E6bu4JJl1v97TkFkF0dGIgrZVG84+kAmeH1+J3utkX5VC7lU1h06+RC1wkKqg+AcjPzd5A1Mb4WVtfPvgUlKm7PJnf1pixaIN5x393axpJ52zHex+NS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTUPxfUcBoOidsF87JZPLzEdMSM+1YMC/594JQbXxUw=;
 b=a1qvgVa4KIE9sWr+lBz2lcVTFeqQhcptGbv+TmGbDAi87vUFnd/tpgfCBnyTDlzXdQPgEGA6C0YkTux/Sz1l6P5gu8q6fRo8A3jaJikqagjUQKpBuiFuVVZgZO9pql9Twp/s9Upxw3UD5B1WB+T1JajRYNpFAsTXShS+Z4D0jSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by SA1PR13MB5540.namprd13.prod.outlook.com (2603:10b6:806:233::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5; Sat, 10 Sep
 2022 08:49:04 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Sat, 10 Sep 2022
 08:49:04 +0000
Date:   Sat, 10 Sep 2022 10:48:58 +0200
From:   "niklas.soderlund@corigine.com" <niklas.soderlund@corigine.com>
To:     Joe Perches <joe@perches.com>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "louis.peens@corigine.com" <louis.peens@corigine.com>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "oss-drivers@corigine.com" <oss-drivers@corigine.com>
Subject: Re: [PATCH v4] checkpatch: warn for non-standard fixes tag style
Message-ID: <YxxPepPX8Vp91XEA@oden.dyn.berto.se>
References: <20220908164434.122106-1-niklas.soderlund@corigine.com>
 <3275d886491dc934e3277cde9cc766b0ce0886ea.camel@toradex.com>
 <Yxrt1aa60xY0H7j0@oden.dyn.berto.se>
 <9f9a0740aef282d30af8fa02ca7c6479e80aa9a0.camel@perches.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f9a0740aef282d30af8fa02ca7c6479e80aa9a0.camel@perches.com>
X-ClientProxiedBy: GV3P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::11) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|SA1PR13MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1941b0-4d63-479b-5d56-08da9309508b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPF7uFXmDS+Aib5mHPrYro7UNmTyJ09sgBWEoIq6dtI3Hy9aYnXBapVxon+Grym5F9aF4WcQIrzkOpXeL6s8M5mn5RP+Fl2S0pa6Jz1w1+i6YKaW8nvoHv0FBpG9XqBAEBumdQJ+kq9v4+8E1QlPJmfIoJl0B/gzxNNzdgdukZkJOF9ontHVXqXlBDV2YMU79I0WSRBhte29Foyf7esGBecgNoC572NXfEJLnFwtWjFwzfO1T70pSv6rMgsPM3Adq1BCx4KLGT8SfTO1z+NRDaDvmXSa7Zh+w2/0O/RefHKz4lonDdFdYwHsWYOrfs031hdxu+1JPC43qM0I8vvQq5BG6SqAyBIo3uXf5gTNIXt/qCOckOc7yetbEjdv6BaapfVJ+M4NC0bg+w0TcOWA7mM7Ny98eo4PfcwSPcMsGo5K1rmZT/wBK5fk5XuWFIhKFY0yankxDzOFNitIDt/Wx3q4h0SeQYnL+57RHBtKE+P+3YRHu3TcVL81JOJywgZf2Sz1hlNkEnpJfvfytgEMOvX0WBBFfTU2L2vbbFbVkNKYEi0moqNJ5I/o2/Y4oZSLl1GCF21YlyCtJHG+NpAaV7ikl7D6tDRqNw2VsLBHNgtWJlPzcJPlf4X3e54jAnc5Y0WTnS1eZCSn/ZCtX36VW7vaJQ5wtdCAy9EG8pJBEkWB50F6kkvrCJL3UBsjB0w9IiYAri5UsmQBnHuQ437Qi2Pj8E6bCigWOGGRs0I2CGHzBhKdS3yR+YrLXtm7pcoS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39830400003)(396003)(346002)(136003)(26005)(6486002)(9686003)(66574015)(6506007)(41300700001)(52116002)(6512007)(186003)(38350700002)(53546011)(38100700002)(86362001)(107886003)(6666004)(4326008)(5660300002)(66476007)(8936002)(6916009)(316002)(54906003)(8676002)(66946007)(2906002)(66556008)(478600001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SLHNWQOFkCRnLFLj/obCq7GqQzWT5y21tk1ZYbM9KNBmvmvemZPzf0MlPJ?=
 =?iso-8859-1?Q?WBOP296Bl/f6sWuViU9OA28+n4ZXHxXAJysX6/1ufhSHcpwZe9gzYOLRDB?=
 =?iso-8859-1?Q?rSlx8kxNZhM52jNrXWxC+2x9I8LbjII3lkWh/nhCJPd2Wy6mJFYrvLJ4v1?=
 =?iso-8859-1?Q?kRdFiskeQpT1H87suRkJZlIVwEMiEeb3ad2MWLCztoSoYV0UGpns9Mu+RR?=
 =?iso-8859-1?Q?WV+RgSnvSTDI3aOqXfHvSHUdYZ8dsoZnf+pGtk95T/dNbvHKS2znwsO2xW?=
 =?iso-8859-1?Q?Qkn8yl2kSupIAxXxIbhnvLYwNFSCBrQGdSBETgRocIeQ+WzpNQwCWJwhrC?=
 =?iso-8859-1?Q?imdnDnfU6ZYfYTLOeyRHXKdqwS1vkR1rFTDWO1h/tbAWd+bdNj08tQnSiU?=
 =?iso-8859-1?Q?sftPKkMuV0ii2b7aTSpOwsfcdc7XpcuAxol8q8nHwmjpxYxO1hejeYsDWp?=
 =?iso-8859-1?Q?LwNzAp21XaDoKeM6yKy3Rbl9WsdhaETZAZnh3Rpl7atwpQA/EkE3aSKSsI?=
 =?iso-8859-1?Q?7mMIi2afXiH+8zgDPBu2zn/gIQJYLNQ/l8dx9pxaTv6T2IAa6MNOkOdvW3?=
 =?iso-8859-1?Q?Tbbay+W3rGmr7Y7F3lD+gxO0h3y9xay0I4JIxJ6xQQg6USmSstC+Cj1Iwo?=
 =?iso-8859-1?Q?kF7mvdQoxJLZuw8K8sIKAS9DWo86GSSllgkyXcMA+p1DjifI5OY6A2dnaT?=
 =?iso-8859-1?Q?IwxDoSpZ/NxtZTWQrdhh/gogvTkz7Gj4cAABM/WWSv1QAEyoDJ/Xc4esxQ?=
 =?iso-8859-1?Q?HOYM8SfUk6rrtlveGQqs8cg/0JI92BepyvvUnARha2DKVCjZ3IMdQz2HvC?=
 =?iso-8859-1?Q?Z2ObU2DroeUyWpMjqsnk7Xoo2TSzc6q2i6gtdc2MTXg+o5BQOO5hFldZ3C?=
 =?iso-8859-1?Q?l/XmuKWqlaKJJcIzPjH6xA6EVmsczQi2l1QJLLxPbb6QV44FZ70Ef2aNMf?=
 =?iso-8859-1?Q?VYL/+3rzQJGBybstXJCGXAMhPnrm42LQ6k5xVYC8WWNsRmkFTdAhN9DamU?=
 =?iso-8859-1?Q?gN7O0PxKvzBTT5UPAlRu5Jne1LuBGKKOdYr65ptgw26ACR9RQOBd+QVr/w?=
 =?iso-8859-1?Q?f3JL90MG2lkpj5LffzRdGjaV17mHQR1NrnyJdwmi/TuZwac4QUCpm8f4hg?=
 =?iso-8859-1?Q?MQ4KwIIVlbl++BAmcVGzQLpOvMl/RnF+65IimUl1MT8ZNnvGWE2i7V/Lms?=
 =?iso-8859-1?Q?m4n4DARw9K62W41IKMlqb5JqrcerxSTH1OY17L3CQe0c7vpcCk/2n+Flym?=
 =?iso-8859-1?Q?KweIr8/Gy+LRyo+pyALDoBvVBXedpREQE75akiS5xW6vhS0S92vZpKojTD?=
 =?iso-8859-1?Q?X6PMDRicFw6s3vqlQiDRepMkviWNXUzJib9ll05eDdzstV8LgQpHfEcNsm?=
 =?iso-8859-1?Q?spSXGaU1pHeYYPHzsyn0AWLyyhhfVL+f+WEfiPNUcZBT3FhK3gWqQSsDWS?=
 =?iso-8859-1?Q?1a+f27l4vNLSQ5XEluqApvwQUFDAoQYcwGGVpGEpWHJ7FJMwVQJkYN+vVl?=
 =?iso-8859-1?Q?6AUvHDfTQmHeeqRc5xrkQJamz7LEtAmiw5vkC+BMkchBRIuKlBCrdgp0HL?=
 =?iso-8859-1?Q?aMqJvOCVAh8J+RvaR0VOSA6u3gsCTuoFwv7pO0v6D/8objaxT09Y6kKCSf?=
 =?iso-8859-1?Q?ecjkH8uR/77QlIijMPB18BE3sC32tLwYJw5EJaiYXkSn1IX2dQgStioA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5540
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Thanks for your feedback.

On 2022-09-09 10:57:10 -0700, Joe Perches wrote:
> I think it's better to make sure that there is a likely SHA1 of some
> minimum length after the fixes line.
> 
> And a relatively common defect is to have the word "commit" after fixes.
> 
> e.g.:
> 
> Fixes commit 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver").
> Fixes commit a2c60d42d97c ("Add files for new driver - part 16").
> 
> So maybe:
> 
> 	if (!$in_header_lines &&
> 	    $line =~ /^\s*fixes:?\s*(?:commit\s*)?[0-9a-f]{5,}\b/i)

I'm sorry I just sent out v6 and missed this comment, which I think is a 
great idea. I will let v6 stew for a day or two in case there is other 
feedback and then spin a v7 with this addressed.

-- 
Kind Regards,
Niklas Söderlund
