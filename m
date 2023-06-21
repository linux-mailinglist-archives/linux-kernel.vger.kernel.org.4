Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CE27388DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjFUPYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjFUPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:23:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CAF198;
        Wed, 21 Jun 2023 08:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5AHjcQ9okfr+68m9AeKWFMemTeZ57Emg650KL3JMkw3uP5BgB2bMFak1pTTp2wtIBCf2Arm+6ab5KBpc/OW0AUwBOfVEcZQqD0YoWgdNMiax/gXn3TxSFo8uSIQUUwkXSc/9FUK5ZVDB4q97/xiZoZc6jiK4jNLcxduc1LIyb+HjZ4qIq323ObX/8oEjkVRXhsYCPAsEABXZK82BIMv5k7JOycr6f7Q5SlMEhvcHEIodXzQIKG85bL5bzgEcp1l4LaOaIRbH/Z16cgir0hrQz3BSXmRBl8OXWDt9Mcx0kGhxon0O9fJqfR9KiWjbyyzb4JmFwTFo8P6cTyon4FTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Eitzhx9ToCCs0EAg+MUu25sXCW+2FnpOznghU1yVAk=;
 b=d01GO4YoEI3T2lnqYP/lm0hW4SISKaxgfb+qT+ZD/AyZos+QVu/IY7fQGdZGL0AzrErZju7zCawDZZHC9JS94+u13uhAkOkLbIWJC+EJKUir12Dq/dLAvHkM+S1Pi6O01YkJR5hLq5qEvUMlzWUH3O3txVrhGsIXj6O4Jxw5TrFheV5aZTcZQLLuV3vio1dUrQT+NSjoYY1QEtmsvjw4aB2036ErH2vGylCkvfMTxy7nb6hFTxVGxbCFDludE2Q7KezSuC3jFLLhh+tEAAKfB7KZSt32iwHUztigK64app7h6uJtXUFCCgOTOFBj25cz11G3Sg9vOlWm+sZ48HNC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Eitzhx9ToCCs0EAg+MUu25sXCW+2FnpOznghU1yVAk=;
 b=OveGHIj4qM7lJ78JMU2cuHFthrFAyzLnBk+FT+wBw/uQSmjrZ4YbAcO69FPIkq4NndFSQ1/8C6cT0s4zrCh3o9VadYMRm66ldST8vJziE+yXxGmu7J+n9XmZJppL0Ogj77qyNLf15kKeIQxWie34PU7Qyp5DkoOHmbH04Is13zE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH3PR13MB6386.namprd13.prod.outlook.com (2603:10b6:610:19c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.26; Wed, 21 Jun
 2023 15:23:01 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 15:23:01 +0000
Date:   Wed, 21 Jun 2023 17:22:54 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: MAINTAINERS: add Devicetree bindings to
 Bluetooth drivers
Message-ID: <ZJMVznjjsixOSPu2@corigine.com>
References: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: AM0PR01CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::25) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH3PR13MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 942b6e45-dfe7-437a-6e9c-08db726b668b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYteki1KWUtXMwqACZKhuEtJptPwQEkvGzvaX1yEMorLOXIq8qZUugpyPH+KF5MN66LpDf6QrQdMoclFbUFAs5v/g4SCa9a5dtkRfAwzRuQlzrHL/FPinfgSJrCDNMKNtvdGk0+CqrzyNrk8Ol6BlhegZ14kPBwyLtKj6sEpOZu944xxzmcoQTtXqb5fbqY9UOn5FyJ9M8uKVk8YJTkx1rSa5mE8uiTwSbLZH7jiY6VzdJX8HguTpss34tiWb6Jj3l7d4EMCUA80w6T2OC2XUdRoe9/KbNsRgIjX3p3AzasG5fa2oyoet2ByfqTBqaXpZ0GA22s8CBYgEUpd7JDAvz1vcpls+inm3aqzr7GWo2ISOx3hOeBwGcqWVrwNUFjpHIQ56pS+HewrWjEiFNTbBhXyOe8WIjbUSwj7rQeCWvhJ+pKxJ8YQkRhOgYdlg5T65kdVpLsRZ18quAHI7RWaiB3r6JRAltSSkuREc4dInPGOcZyStO2rGXVh8/o0VAjDTuYEP6qzLh+f5tzcKhP7BTLqEHsuAcuixX0LzptAlVEbzXaa5aasjqW01t8O6u1iz4pd/nZH5ySCiBjhbMLJj3Y2BQCQPeQVQ+HdjqD+M1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39840400004)(376002)(451199021)(4744005)(2906002)(2616005)(36756003)(86362001)(38100700002)(8676002)(8936002)(316002)(6486002)(41300700001)(5660300002)(54906003)(66556008)(66946007)(66476007)(4326008)(6916009)(6666004)(478600001)(186003)(6506007)(6512007)(44832011)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uJ3LE65xXS+BxhhETBzxptlN8ZSutfpZqf3K85JD5pnRUSmFCLXOuQES41H+?=
 =?us-ascii?Q?NTthJPe6Usv5o8sJdCnLBNM1VLozrWV1CYjr2hjk6AdQYGFU+zagFYGo4Iwl?=
 =?us-ascii?Q?ZfOkDeFn2CCqsPk2+k6G/Vzr9lfz+hSyiqbTSg8eJG6bPafCgQdZewqpK5YY?=
 =?us-ascii?Q?U3GJZvhRpuEeufQA+u/niXIPYHRcOBHXF30IArcgxsX1Bwe9Mf0XkOLMC2Au?=
 =?us-ascii?Q?tQ9VKqkSztQC2mMoIT9d/ToPmghsCltGybQkLeaBPKElYzNhyAhzYbcoYcbQ?=
 =?us-ascii?Q?pF7lZY6ZjNEFvGWTq9iupGt3FifPAQ970PnWNshzwQNWOVTXoJhGNOLObHiP?=
 =?us-ascii?Q?hGx8/S35oVtAerKiy/MI0HhhDZmV6FLJW1PQa78JDvchukFOF4JWuulGN1eK?=
 =?us-ascii?Q?0OFSua6UiGA7X3ziTt2TbYdz8JtS+nHj3FZ80FQgBoK55qSZk6jsQe16QOp6?=
 =?us-ascii?Q?QQZ7jEg7j15WJkaSKwRLv4XxEA5o8qVwVTsPU1HCvxIfaRPR28zCGDpdXvwJ?=
 =?us-ascii?Q?GvX8NC/GW6iaq1xzqaRPccNE4F4KfNqJ/gEgVk1D99c8TnGeS+USmX4ICU8V?=
 =?us-ascii?Q?eHWqcE/+sIVdN11VsKr0MwZQ8rEW5EWD6BgFS+LzRGuH3qtgx8eIaicYQljI?=
 =?us-ascii?Q?9zWCQRAooceXu2jd2Whir7Htn/dueEYIhBP38ENkqlBy31ZBBZKMHRpaI2+V?=
 =?us-ascii?Q?MAXIDUCzIgFnHBYGlF6IH8zevt3jUSS5LqQvFYraN91BRPcflLWtGBYT9EIW?=
 =?us-ascii?Q?oMS+QOEH5UPTphHsk6HVYvUXLBgh63s5vqOq/SFpD2B06eNgdES88O3MtoOK?=
 =?us-ascii?Q?KUx9w5iLLY64OSdRXAaC4H4KJEH+iWhTjtetxLjC2nQ6l0Qi1E5Qw1fNKefI?=
 =?us-ascii?Q?YeJXFKAj4f4r+E+7S32TFpO0235J1y9EtGOkIgVcG0WCQtsZmjnc5zSM/aZy?=
 =?us-ascii?Q?7DFaiRd2IgOVDNl0fQJuVVknvmCuV4pdwLyvl+Xqz4Emszi5e9N4aUgG8lEN?=
 =?us-ascii?Q?a9owCgcz5Q82nao9FjyOIkfgyD72FCsuc685T7qvxl027VoMBzAF9soti5cX?=
 =?us-ascii?Q?/Z4x1HPR51bas2SAwF34xP92mCJ4zMQneVtBhNHUxbuiAcCZ7CREepNl0Wwg?=
 =?us-ascii?Q?fUhVGVoDn/dA1OcxWuYqPNaLT7YyVeTa1E0OykuKZOKOX5YOunedIpvvMjpT?=
 =?us-ascii?Q?UsglPweRHhxVzhy7yewU75syHbwlthA46N77krA4cFO/Mf/njlaEnsVoN9CF?=
 =?us-ascii?Q?Dls98CUEnDY36gRQB7PURA/EcjPQ7Tu/2vH07AEu3W7ujRZeSfkJhwnHBfxX?=
 =?us-ascii?Q?wVAkrewMo45QGa0ZkSegBx2zFd7v3cAsx9gKL0s2qSW8x2dBjKbnDtFD2PY6?=
 =?us-ascii?Q?FDpXEMpvqJvq+7MFZ+mR2U17ZkS1BINygj1JhpzznJjZH3VmsmVRcahuYoHC?=
 =?us-ascii?Q?DzzACRe3/3COZ0+VmIG6OjMxOgd0o2rDkJJa//wGOXpH8+OGKdijFF3KbXNU?=
 =?us-ascii?Q?u34CUYbLU9RZciQejaVE1+hkMJRMRyiEsjU2fYsLv3BQXOggQXAzQr/7hsRp?=
 =?us-ascii?Q?cX/rnZkNEuAVPhRx9ZuQdQsVIbJhqPVbWv91PHtN0paMh3BKjD/6Vsn1JoVl?=
 =?us-ascii?Q?FpAM1PFmdtdiQLtBhieGruLOzg5eJNfN4kNVGPrnc8+XkqgP3R2EDB9z1X8H?=
 =?us-ascii?Q?Ty/IXw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942b6e45-dfe7-437a-6e9c-08db726b668b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:23:01.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuM7poKzAvOQLx6RofF2lURVpCch1Sr+x+E7HA+CG2gJxU85gck+pl/hLbtC2SFHCglCiF9fwSxl8IzFXIu0DwohMDAm3Uf0gYGWinyZqB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6386
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 08:09:49AM +0200, Krzysztof Kozlowski wrote:
> The Devicetree bindings should be picked up by subsystem maintainers,
> but respective pattern for Bluetooth drivers was missing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
