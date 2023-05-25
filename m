Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837827108BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjEYJWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjEYJWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:22:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2101.outbound.protection.outlook.com [40.107.223.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF92197;
        Thu, 25 May 2023 02:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cujpihuT8825avg5giw+vrptpUq05EYWF6if3jJ38g956kAtOUBWSwwDI/pd+sllUjbhD6nb3xsoSg+ycqjYgtZRQt1eOOUyyOWtx4priluxk04rYdHORlh8foDZoGo91Xr27WWatae5QaU1/ZVxb6XmaUpTMzTk7YzxIxI+nALovVhk7XPMf7INTa3UZVu09am/kUh/P+mfdfLAv8/o693FUw3aE7EE1iZpmZvR0XZtE/ky3HiqMpgenMjjD44Mcjhy4vdRLHq6wGh8SCl0AR+rWJjyJj+huuTybieotReb6CMjsZrSNNVtUYheLri9febFMXMvolz2ZpdPLd78gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMfO/vu32VurDggZt36LOymkWd21xbA6UdoT+pTGNCs=;
 b=dbXhp5azDA11Gd+kOrplpiKWsFoy6qV66bm02AvAgzbAeIfipeA3NrNAbp7z+yOyzdIjC/54EQNBz0y2DzbSpVFPNzOdXMovxZ/SaxzdmCw6Np6d6T90lwwpTCYbK0gcGzT8gd5ry9xF8RwCZO6qnFy8iYg687teZ+Kbn8hlSh29p8MKB1VlnfPA3YDnZmHFDmmWIC0BX3J/6CCS2Nau99HsMrPXfKvaOxdtSAnfK1fPvIq67VntqlNobhp5WzLQLfUZPAefyEf12RHxfGiq5AszXsY3sTh8Ov82/6kR8xWBrcor/fh0HMQ450W4voxHbYPNH2lICmSipuXdXfv6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMfO/vu32VurDggZt36LOymkWd21xbA6UdoT+pTGNCs=;
 b=UEVTCT8Yvgb5sqokHgql6kYv5Umg13mqenhUnOkjEbOmPnoxUE3u3+fzybb+P+tq6Hmj8J1z2PQT5ISSeE5IhuV2IkEa0UACS8p654sOd4zvk8UWjBCs/vP8fbc586gyB5eoZ+HdlrOXyzakVX1FH1t5FPR2vY9zO5SVqcebsXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BY3PR13MB4834.namprd13.prod.outlook.com (2603:10b6:a03:36b::10)
 by PH7PR13MB5594.namprd13.prod.outlook.com (2603:10b6:510:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Thu, 25 May
 2023 09:22:09 +0000
Received: from BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::d98b:da1b:b1f0:d4d7]) by BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::d98b:da1b:b1f0:d4d7%7]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 09:22:09 +0000
Date:   Thu, 25 May 2023 11:22:02 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Simon Kelley <simon@thekelleys.org.uk>,
        Kalle Valo <kvalo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless] atmel: Fix an error handling path in
 atmel_probe()
Message-ID: <ZG8oulcaldoFLOPl@corigine.com>
References: <1e65f174607a83348034197fa7d603bab10ba4a9.1684569156.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e65f174607a83348034197fa7d603bab10ba4a9.1684569156.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: AM0PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:208:69::15) To BY3PR13MB4834.namprd13.prod.outlook.com
 (2603:10b6:a03:36b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR13MB4834:EE_|PH7PR13MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1377b3-2f87-41df-a697-08db5d0183ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYP8y0v/QKc0iulvynUnCOWOpxOHdW+M+HsIuDzFpV1WhvqOfz9l/8/4mjZdXGKKXv4BwG89ltTpQRf3gdbEiM7UcPVx+UOYVH1Lu2m5EsPQa2HOng8o++GDQT0hThIWAaCk2uJcm5Pe4x21b9rUFLV85rAOvF9MUClO2oyma0tIJvcmu1c2W4EJkoc2FuHCi0QYq22U1cO6ntlGs1Iv8OrAYNH5SjW35eUuUwlzZ3lC15Q+bd52bRizGWnfn6QRhWc5VmSa00+V1gae/YllhtBJCPAXA1uP5kWblOV9dAqsS2mFX+TBVtPEMqJ6Jqh4QyvqHtvYb9k6UT/kuJIoHBxvp8aIxXNr7GPa52enD87tTWh8RZYVGN8nsAXe6uEC9bkqM4VSr3yfgF43EWm3nYbtKEMQjGhA9cNghkR4od54UwqxYwk7UtGj41iO3pGnkIatZstAc+Mm31nnuC3q5WX1CVJR+JdBGROKfXACo6RdmQUzvyv9yH65LScizWhv+GmE+Aci/mRLkKTuqf9YnPyHkiSYtObWYx4wg69TrE5r77g4eO/yBEGGsDhunoYQSkwvw43z9zxQMfLjIB7a/b0pXcLqPG6ofrJsyies6DA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR13MB4834.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(346002)(39840400004)(451199021)(8936002)(8676002)(5660300002)(2906002)(4744005)(54906003)(66476007)(66556008)(41300700001)(66946007)(6916009)(316002)(4326008)(478600001)(186003)(44832011)(6512007)(6506007)(6666004)(6486002)(2616005)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4K26XpnLeh0uIQZcjMkKs/jPRadqNNIY+a69KWtyJ8qMs16jIuTXaG/yPGOJ?=
 =?us-ascii?Q?u9uXjz8v3DCxH9DvfRC8t35Lqnba9OJADA1MZFWWuiGMlujJ2Qd08DZ9kc5B?=
 =?us-ascii?Q?FEJWX3WsY00WxQ96TVlOT7NTKioJjqc7ByChaUbMDXIyodvTuCY0Ed90GtX5?=
 =?us-ascii?Q?L5OvnAbwZV/fUwFzM9FURAUVBR4D52YXEe5uTP7hSOsiFY+CslVm6XilRuur?=
 =?us-ascii?Q?RP3UHbvap9IryMlvJJuEmWVUXdi2Poa0nQCWJccQ5KqP1LmwYzEG1m4agf5a?=
 =?us-ascii?Q?+m9sggswv0K19V4Ohmrqi2NkNVXYqdF5Z39gruqrWibCc7W05cT+wS/NScmp?=
 =?us-ascii?Q?8w3ZsdT8cQCpYa3neQoHTJsasiO1+w3vt3dE3v4pRw40MnteDIzedVBK1uVU?=
 =?us-ascii?Q?6wil67qomZ1AvaiIQtu07LyhEEkdKI68t4/zyACIRwKTSpDBYP1BBaSDkqkv?=
 =?us-ascii?Q?oLrOGVdSMmX1rVEUzt3hrlIrzbMIJ2JvAm39qFC3XiKoNahZvZwWEcXk9RSJ?=
 =?us-ascii?Q?T2qz3wy6+J5wDXlk/j9aCNRw+8BmPvpNQie8oscdWRwqRYLhhfKDsQUVeZlE?=
 =?us-ascii?Q?qP4X+s3Za2lOMCOg2ExFEaxvRoeKu0H+5SGFw5O+bn5Kup9loUaqiv0NJWIH?=
 =?us-ascii?Q?mdR4vdYha8cX6gfJboKrb5mfIJiDGgT1GgtQf2mJ2gKvuJ0+gSeedvgi7ion?=
 =?us-ascii?Q?A+vnCXVrEswlZc9lrc1GtqQGXQyNU58Un8KxRjGuNqefoRelcFwcXw3ZKjT+?=
 =?us-ascii?Q?rS6Zy2M/IBYW4krZCYJGr9irY2U+8Nt5DH4ryyPpnoG7XmCkuWz/j7WUbmBE?=
 =?us-ascii?Q?XiDtRdXT/73QLep1AE9Mll/Zi6XWlkaygHWuaT9Jz5xCQLwQGBu+fTsQK6w8?=
 =?us-ascii?Q?M5TFKAz+Bi8IVtRHb54mLBUFpGjpPP27gFs9qL9kjmLJdDJTCHnRFtuO/QDt?=
 =?us-ascii?Q?Jts4ChcVyhQN1AyhuSqg7WP6EwzvtOHRnsra/ZHUSICQOdIc+9Urs9h1IDc+?=
 =?us-ascii?Q?fdp4QP2WypQZsSbbTQCR9gT/1H4+QfXb1QliX/MnZ3ekc7wSKdo/hlh2hRyH?=
 =?us-ascii?Q?h7fB4Oa6ugXlwNydbC0Nf/4LIlkL4bRVxQgL5Y++0ZnoOQuBy2/91XCfbvhL?=
 =?us-ascii?Q?UvYDOYY1nUyozNv3FdeGG4Pak+cvv2YZm65yDZdLeS5e6nu5LslxnF537aAZ?=
 =?us-ascii?Q?Z/j4cQTAAn2q1FTcWn0oV8jSerUgADjK23PAiXy6j+7pyeFpLzDp0beXaB3Z?=
 =?us-ascii?Q?sQ8pjhKDWPlJKoDf8NBmWlWkxH9+L/bT9/PvixzqLxjTLr4VMT6cgwXTCIIE?=
 =?us-ascii?Q?JOcPrW0SHHI2QdxA0rPaAT/+s8aw0zaPpNB+/4hX31t83yA6ZYhtNZ34Xe4s?=
 =?us-ascii?Q?AzfIe9hpReJ5xH3xEY3lvKDnHtmi5gD08NZD56zZowDuhp7yqXl4HEiyselY?=
 =?us-ascii?Q?or2ozYJU8a0H7ATWJ91likr/2fQzGW68oGVZFpSyLLl4naRJtOHOFJN50nb1?=
 =?us-ascii?Q?MS7VyHR//5LCfp3CoKlXf+r8ErD4uNXIrIeSGJkH7/V/HP10O3ZzdLu72MPK?=
 =?us-ascii?Q?B0rDdL+YJl0O2F5FNDUBN35qFWoh/VMgfjIEB9NqsA1a+YZ5pNtKJCXSefHw?=
 =?us-ascii?Q?2VkDg6E2jTMKa9bnqr/CodbzWhN1tTrl/FqzbPVjfhK0G4XLlaA6iH8Y78Uz?=
 =?us-ascii?Q?2KJMJA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1377b3-2f87-41df-a697-08db5d0183ef
X-MS-Exchange-CrossTenant-AuthSource: BY3PR13MB4834.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 09:22:09.7626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAxK/QW22W7lb2xMLBO0VPJa8NVBBbW6oon+80kuD7YIfUscCRnwIrkaKyjCqHzpCRtfm7KirGySr3QByhrVVs7jDHMYyZXMNrxdhBtuLQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5594
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 09:53:14AM +0200, Christophe JAILLET wrote:
> Should atmel_config() fail, some resources need to be released as already
> done in the remove function.
> 
> While at it, remove a useless and erroneous comment. The probe is
> atmel_probe(), not atmel_attach().
> 
> Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

