Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D104574DC6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjGJR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjGJR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:27:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F897E79;
        Mon, 10 Jul 2023 10:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb/umGixoupN5kqk7YsPotQ9rWGVQtAdaWSpMcWlOfIywV23OO81aSrA0qexmBovyob7S1hHYKnrpKlTGi4akisnhkYVQGxyEBMgk00nC/K9LXXXHpAJvms/r3w/CbTIhiXWjoWugH+jLS0iJBS4y0W/6ftO4jCL9TlRjKvEtWOIC0n9DdQBA2QElawhjmAruHVZSKDS484rWxHAc4nKdBZSV7efnAFLP6vquBRNYtVoMZzXNVodpZX8vQ9KrWeWLAalVmhKFAi/UgqGdyg+LLXhb2bM87kV+7h/NKiqwUUsIQW7f7dnUoc9gFxunNksUKDrfbPDqjSnqx5bfIcHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fo1XxMyAKRHJ3c120OnuS+OHIdATo0YImdTEabnIZg=;
 b=ImKb5mPkZ0dPO+EWRr7a+pTxilW9ZjJ7dcV+gZ2aFwc1XQaEb13RCg/1/deusQ/eN2BslgmFv/8Kfx41SkvvseLyzhhObon8B3QwTaf1WesxN1gqwNdmQ7SfFoxuAReSF3JQoB+ZLmbrRmMgdUgm1NoF4o2QnYUI2QEXS1T1B8GO89O0u2Ir6/GCjUpOFd26K9uoacXbH65CTVCixmDQNxQvbvKEQ8PqxkQTTJCbcy8DLSYr8fLW+KGjtBdvs7EcTM3o16SYMIvw29tqL2Srq9MrbxS8J4mjCF64z7uPVohh7RL5M5ZqgKYnga4hv2R+GGc9MaOiEQwigdL2UkoFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fo1XxMyAKRHJ3c120OnuS+OHIdATo0YImdTEabnIZg=;
 b=mL6be2Dx3aLkVpMHw3Wg3+eaYsuOytFm5sQeU58NEOxBU4V0T+4cnPQZbBHS7xdYhZ/a7OL0w5k4vwkGnd5mbSw1hUPI6DrMUuuNAtD+f6RGYgipiJefdr1qbaWhe4GXPdhyOZLJ4GXHfpyp4OQPeI+xQr9kZpWlFcc0SqSM2hHpoFvqsP5AMA8pqdXoX2d1Qhth/xk6s9t15ENNmt+GPuW9q2NnKtWo1uyysoiKuG5+sNqnYcb1kY27Yq+X6c32u8xAPV3LsAl/EpOIvOrGPLJL1OEjTnd0V6VZs5IxxaPjBj7Cgcs82iGqpzWUmoaxwxkhmDc5AiH8fHjA60WWKw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 17:26:41 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ee7e:9411:ca2b:85e]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ee7e:9411:ca2b:85e%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 17:26:41 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
Thread-Topic: [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
Thread-Index: AQHZUHBpmwUyJW1DpkeY8R87iuQYWq7uV5UAgMWucrA=
Date:   Mon, 10 Jul 2023 17:26:41 +0000
Message-ID: <CH2PR12MB3895877A81288A737B702129D730A@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230306211237.14876-1-asmaa@nvidia.com>
 <ZAZrKPw38ERSbzXg@surfacebook>
In-Reply-To: <ZAZrKPw38ERSbzXg@surfacebook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|BL1PR12MB5142:EE_
x-ms-office365-filtering-correlation-id: 9ff0a478-2468-4236-d5dd-08db816ad328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lJcZ8fu/aZ78w0sw1cDcWtCSALgYUIxsOVk2gNbWHaaiXWSNJteGzRDa2G5sKan8WpUyLk3bGCWNhl9ix5nW7P3hI32OIK1UhzUW0VoPYjU3eOUOmR+v8qPyqYwLGEw9/wu52W1vVYdPU2HB2tDgNKaOATietDeSgjiVBfzkONXW0Hn7qZnpM3lnRA88EvHQAABN4/7PFxTYjbDO7mg75J/kTaNTuVinTtyGt2kQcMeoBGCbfBL9X9AwzffCk0KfoLFefP61rXnI1oJnSSUX47DgSxbRB8swIIn8z6EY6tnEBiXS6aiRNr3/xK9lDiM/9gfDovPEgspLhe9yAh5BlQQv9voanLqWLGXzGRmA8JQ6U6u7qRpkO9fqR89A4zuE0gRump45VAb+xbU5ksjBLa/otXhLjkBg0oWz/5wZVjGqE2e6f07DOfU/giiG2Gvfh1Pb1oXwvnY28eFMGNxdx3Ol3U/RJUMrBIAMceeYSNQ16YjrNw/eNgHpaDpZrhYujPZBTnXRk+4Zc4jvBV0GNCz+AufRXsiKjcfjRAR2NF20NR0ZPHfAl3z+5GRFTjt+r6kEmHjhDaVaa5/z+//m3hOUb8Bz7oTHvkRBHKKkTK3E5vkDMP8H9Knq8ryQ/DMu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(38070700005)(558084003)(33656002)(86362001)(55016003)(38100700002)(122000001)(478600001)(110136005)(71200400001)(54906003)(9686003)(7696005)(8676002)(5660300002)(52536014)(316002)(2906002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(8936002)(41300700001)(26005)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hk/tKgd4CyPP4ZhM2sQOFfeGNBE3BTJvH7HYZjiQKmeEW4zoZCvp0WLxKP9s?=
 =?us-ascii?Q?/DxTjh9JqOgoSjzSjgOuZpCyHlMYbMuXA4rzWCOkj6MNO7R/XiICc+kdkxKZ?=
 =?us-ascii?Q?77fOODf2mgnFCk+uQdVS0iOopuwscy9dX3NLDEmhlnK0GQqOfB+a6YtSv7TR?=
 =?us-ascii?Q?tzaGE6OGh1T3v7bpnsyj9eQkWSW7xf3cmvMgE3Srl+27XwPooTQG3zSENJNb?=
 =?us-ascii?Q?ovLZcJF0FvV/flOZa82JFWd6u/quIc12xktzCwCCmHwMzGway7neJ7a5WLgf?=
 =?us-ascii?Q?50ghK4wauKOomVjXk06NekINm/T1DG7JadkMLu8Ax0gBI07xi4jYF2aZd4eK?=
 =?us-ascii?Q?iDSCfFInzKoXwz/f05/nVMr2GilZdz0XOtTRa/E/ATMFHJ6K5xzdZFx3cSki?=
 =?us-ascii?Q?FBJsFEsH7nxQarKX68myS5iIJ2UueOg9HVy/h0EFQ+4BdV0hKw8jvGeTLdsn?=
 =?us-ascii?Q?9mvVmnb2jeanYGckEzAya4uwdZzq0CSTBr6kbLJAg7JtJ2vrPkIugWiXUBf3?=
 =?us-ascii?Q?Qy8uVksNdyGpLVLcHUn47NSEoAGMnkQt1+mCupgLdJYH9fVl4hb7vA+j+L3z?=
 =?us-ascii?Q?2D5Kd6RgjxBb8/t3PdmKOeqFu75RcHV8qW3+uzsK95vsCqmBojkJIYqitjwK?=
 =?us-ascii?Q?dgLff+oMk7tWzGfyIexoe7LWj+DuEzLPgg2zkB6oeRZhW9MLMjgeimYP86W5?=
 =?us-ascii?Q?+t31osgjesKzxw1bpZo3e52on8CaS18u0662oGRQkXfcBcp6RMVDHOxufVln?=
 =?us-ascii?Q?9Dd0htx0ZHbMPJv4hWGlSvGjMZ9z/6Y4XnqnsJ0IRnyXG6wHCTRu2QuIiMpo?=
 =?us-ascii?Q?Xp8qqWE7bBbaJEVvaC9PL9B4dScOJo8wbOuRumAaSQd2TN+zf0ESpVKjdN5p?=
 =?us-ascii?Q?KhOwZbxutlvp+Af8UM5ixq07hjC6K7m3tzMWJqoHXRduTGFnK+KDM4zA+g3L?=
 =?us-ascii?Q?iu0/vSCVuzuK29mDBh4V5uckAN1vwzRCncb0rRdsytIYwWxnT2ZwoMf6d+JS?=
 =?us-ascii?Q?odSKmjQEne8e/2wBSdS6FsBNKA3Sstr5rXuDosy1zYje6D2c4uWGIPWXyC0x?=
 =?us-ascii?Q?SR85rN1haV47jGuGEE465C+9g5rcNtB05LuuX3TvtGh2QLZ03x1OnSRi9jzx?=
 =?us-ascii?Q?MKXLoa5hwfK8Th8i9GYY5hw570LywCKqz/VqtuQ24IrhKW3RBUSnY1wfecw9?=
 =?us-ascii?Q?0tqb50mhyflMzz5YFjbTV1dhAHIE3xznOBIBJQy4c2xVYdOuFW4dqCqW0FEi?=
 =?us-ascii?Q?A4UNwuHzkcX9RG5JNbL52b+1CNF9NACxQMVh0SCBXBuGVWEsrq5rrkY+FT4Q?=
 =?us-ascii?Q?N0iC26Uz9OdTiDACOBBMsq8fPl0RXyPz/SVZmH7eo75hnM2MTlxnM9O0Lqqz?=
 =?us-ascii?Q?V08spN7u1mzdKptY9oyZG9Q1rUw5ntDY9aFjiDAnu13pCmtGuh6S0DJE/1FO?=
 =?us-ascii?Q?xcWmAEkG2woHI+d3UN04jBgiPJxkZy2l7/hYDodehToineYGiJ03GAE7oFxJ?=
 =?us-ascii?Q?SynqzxfxzFqsiOH5C4AT9rGmz97kd1LJsjqAIp1lSWl5nqx7Q7fvyufhCedl?=
 =?us-ascii?Q?8QxLwKdR0JpIJ3a2bGg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff0a478-2468-4236-d5dd-08db816ad328
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 17:26:41.2224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wlw0Y/8sr1N6CRl46MieEeROkFuMqx7DGsN+vzuE7cHzNgVwd0uRNxYB10WY5tNM4yq1A+7noJx6tak/wy6Mdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Hi Bart,

Could you please add this patch to the tree?

Thanks.
Asmaa
