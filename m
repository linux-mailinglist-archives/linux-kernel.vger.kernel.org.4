Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38291651394
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiLSUCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiLSUCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:02:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6048012D25;
        Mon, 19 Dec 2022 12:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1iI3pBoKeS8cZmuSEjfBNoisxxcf30xZZZe9lqtvvXE=; b=dDZ3Ltiw004cYS99XO55SKnTn8
        NUqLCtOjD7EQSpZUApNlIsl63YP+uDZstsV/m8S4ajnozuyGhe/0HhFW9KlZdjOPq8VXSgqvijjmf
        zxu8+rAXjU4V714a3KqtlUiPJdMiceBMVO22qF+44i/kZ0PnRx9QTX/RYgKlUeeRNZjwZqmVFd7b4
        EcL8k553e1VHV8C6YTPrhuidwv5/H2FnC8GRCi5Po6bUoOufh0+7Prn/O+cHBr7/wgFb4r9299q9c
        xTPUnQT8wofX8DR/ae4lYZecz20zd4XT8uAaa67IvNCZe5fu3R3EWvALJDnvsIvaz74Pa6Rz7ZNJo
        z65pR8rg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7MKq-001aTd-Cy; Mon, 19 Dec 2022 20:02:04 +0000
Date:   Mon, 19 Dec 2022 12:02:04 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave@stgolabs.net,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] cxl_test: upgrade as a first class citizen selftests
 capable driver
Message-ID: <Y6DDPGnwszUAiNh2@bombadil.infradead.org>
References: <20221217034947.1174795-1-mcgrof@kernel.org>
 <639d4bb71bada_b41e329452@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YXCgAdvdBK1pCYWW"
Content-Disposition: inline
In-Reply-To: <639d4bb71bada_b41e329452@dwillia2-xfh.jf.intel.com.notmuch>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YXCgAdvdBK1pCYWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 16, 2022 at 08:55:19PM -0800, Dan Williams wrote:
> In other words the suggestion that the current
> organization ultimately leads to bit rot has not been substantiated in
> practice.

On top of this patch I just added a custom debug patch to my tree which
enables CXL_BUS and CXL_TEST by default when this is currently allowed
and it got quite a bit of kernel build warnings. Although some of these
are specific to my change, some of them do not seem to be related to
that and likely could benefit from fixing:

https://gist.github.com/mcgrof/73dce72939590c6edc9413b0384ae4c2

And so although you may not see some build warnings so far, it does not
negate my suggestion that having cxl_test as a proper upstream driver strategy
gets you more build testing / coverage.

> The proposed direction to move tests out of the ndctl.git repo into the
> kernel solves the wrong problem.

That's not in any way what I suggested and is not the point to my patch.

The proposed patch does not suggest to ditch ndctl unit tests but to
*enable* also sefltests to make use of cxl_test using the selftests
framework, which is very different. It is not saying "abandon" ndctl
unit tests, but rather, "also enable linux kernel selftests for CXL with
cxl_test".

But more importantly, it looks for the value of proper kernel
integration and making use of kconfig for the actual dependencies
and requirements. This is of high value.

In addition to this, one possible area I see of value with this change is the
ability to also use the wrap feature later, even without cxl_test to enable
error injection. What would this look like? You simply replace one built in
routine as you do with another which has sprinkled in should_fail() calls,
which otherwise would be an eyesore upstream. This shold also then not
depend the rest of cxl_test stuff, but can make use of building
alternative wrap routines which could be replacement for upstream ones.

Another benefit of this strategy is you can also test cxl_test *without*
the need for for requiring modules, which some folks prefer for testing.
At LSFMM this came up for instance and one of the biggest grudges with
testing some frameworks was the dependency on modules.

So requiring modules is also limitting from test scrope perspective.

> So in terms of benefits of code being colocated, tests + libcxl + tools in the
> same repo is more impactful than tests + kernel in the same repo.

That usage does not negate any possible benefit of enabling selftests upstream
too.

> I know Jonathan has some latent ideas about building up a CXL regression
> suite on top of QEMU, but even there it's not clear that would benefit
> from being developed in linux.git given the tight coupling to QEMU.git.

Definitely not. Such tests should exist outside of the kernel tree.

  Luis

--YXCgAdvdBK1pCYWW
Content-Type: application/pgp-keys
Content-Description: PGP Key 0x002C0B2920E6ABEF510EFE4FE1CA73A3C9594E24.
Content-Disposition: attachment

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBF0I89YBEACVX71vjnokOZDiy/HD5IuiGCg6wJdphzg4N/mx8vJ4NO6vRzty
1WoD9K+WiTpggZKTXdc0rq+J3Pmdfh4agq6/GMtodCUIYxvIv3zmGRqBf987RNKC
1CLIAScRX7bESs55T7DzTHk4uNrAKpBNT8q5fQkoLlWGbvb5LRZhGfbZgKD9N/N9
t5eQk9ULPXFebZ+E0V5K0vGP57ucKFDoembY97Xa1lvDXoZ3bObN22XPZubF8a/o
JBjEbfhK5DhOQ1JY6yDgeD2NBqJd0LHOpP62sVIuPAYFVePNh3Yfx0Qu/xIHL7Il
06MTdyLrjuT7IojWQF87ysLCIVGZ+SrNM3XB51NyzpH79dAjoz93bSPsb6vKNgey
TFM0FgRyS8hSkcBaltM5JphZypdVoGNflQk/m/zcMhTxNZ2P6CHSjri1QPyIEN5r
BdNJ7miHWHQmvwx2zxblUL+H9Hlv4Sql+Cr/IlJCWReICCDdoddDTFwTWULf1dfR
GitInkSy5Eqlw/riOfeaMXeUhhdtwSIu9SrqjgLQI2UGA6dVWPnjtmFHgPvJPHpN
CU95GzS5VpU5XlOuQAWrEbd0iosDi26ZhmAMY/4FMnbv/HJnmyFu+9cyVtzJ7PAN
LfboGom2DO0YwPQYRo1skk3cOpFAALsXCHLJiDNpltjJJ+wkY5MfiqhtzQARAQAB
tBpDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPokCVwQTAQoAQQIbAwULCQgHAgYV
CgkICwIEFgIDAQIeAQIXgBYhBAAsCykg5qvvUQ7+T+HKc6PJWU4kBQkHhp7yBQJd
+A3UAhkBAAoJEOHKc6PJWU4kT9IP/jQsOCaAlB/dBRiE5tDMrqffRBNNxtFLNeM+
GNeOzsmQWlMO6rxXYe7+g+842YmJQ8H3SR02pj+bU1r2uvSMbSDNEjeqmQ/RF5mw
nB4aNeQe6OZeAUDHiQ7KDJLGretONWY8+txpjB3YpQ6zbuWsuzlwZJBdUxEa50wN
clfxhKZc6KgHfv05X5V0ZCs6QCwA0Ti9Yu+FsGY3DCweW4PMM43sho+jg9bEwL78
RKqKkFUw64DEr30wMSMFjsEzUEWn46rB3HnnwQ4Cp40TPgUGmwWIPdQdWCLsDMmH
65DC953xfI7riSrqwfeb/VYKAZI8go4f2yodwPx73zhF/gU4ltY1/gYXFssAnSF7
od5gZBWvNaXt6H646ydDRU6sKW8M/OzR946lfggmhk1VzyNWhxQbAtuCsWbOtoCs
11vm/fBuKeYZFOyMAyMTeUgMqIwvYwHL44zXwEGcLFBnVK2jOSROJl8A6nUPthh2
I4JwbIzDKkrXneiAoaLQOQ4wYYxc6N2AovqrHOlS2FJ8AbNFgRfM5cugIU1Pw8YH
r22UF4dYKA93RvPUueoFKQbZQTgMg4Z19MD1M6DHCEwIQO0kbPckatbeepk8oLjD
cY06sIP0crlGgyEjboS1FVyFkA8gqSMF1le9coJq+dRtTx+DZvTJi6cFJdM+5qdk
CTVhCr7tiQIzBBABCgAdFiEEs/JGnXjXi9CdNm83yUA1whtPKusFAl46gZwACgkQ
yUA1whtPKutv/w/9GHXjLbc9G6xJXNC8tA8dPC4ypKXypXldZTIjz2TVqGzIRNth
PH+bUVzvekX/qH5Ha0Xpt+LD6/L3cbbRtf+AxQ2RiLqLrQISJMZY5ctz4kvjiBd2
5MotMEBrjmpO3pdCAEgIkcAdaJux+Jejh/0XtVGZb+MBBGdH3QlfMJwlRm2zrl6n
Kzsr27YqIikPsEI8rlUgrlDJsvojcO6qo6ybltFUJ8udhZ4k5piHpRpkZtGzhxd7
TM6+w7rfhdVk/rJkjJTB7h9vpDx0XNQadCJkz/R7SsYm8gxoLhu5jvAYofS+fhPk
u9OnLRY2WIJtBnNrzQBmpmuBDMNGNqhgmW3VCMOlH7h+Mt/zhqBoNUWwUGqMbwpU
uefr1IupOrn3pm7CAlf0bkCRFVuH3hm0DYvz5bAH+ajmycqTRKMETKDvL1XW776Z
C9FX9dgieXCZykmpSVMHNMgRMFHx27FKNPFxpPz9WbLWgAAx8yct3+1pNRlAY7MR
fnzu+VShMGBVQ1yWYrLFG4dA105vOs7JQrmyTLPdr5Bh1cQHh+c8uAwuY2TPNYBd
Rtt15J8b9paPlZdWWlz+z4E+uLNBJw1jRud6VekBe1vF6lPagikhe0K9vFxhRxDc
B2W+4XU2PPSRCbJKcVP3FObu9AZTcD+QK1RkUpa4k0D9SxS3PHpbkkoO7tq0HENL
IEh1IDxodWxpZ2h0QHlhaG9vLmNvbS50dz6JAj0EEwEKACcFAl34DcsCGwMFCQeG
nvIFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AACgkQ4cpzo8lZTiSBug//VFrAIrAK
eHkH3AhVBpt1MoXsLfr76XPYvJ6517BmmtCZ9Q/XxxXnHDM3nAxLeAB6ismORXDW
u5EUkrSpCZDppLSwFFQkUpG06xCSbM96TMsAf+nJlUCfopKa8qsnaEA1ew8OUZgE
y2tCGYMDmm7pSYZGtvuDmuP2Ah6kn5Mjw4dy1Ko5iATrtN3qrFxwaGuawMAhqCN0
0a5WGI7xif4AeFvpMAuvi57GhVvSUft/jD07SHtdnipc/pBa5MMIBHiphqxJWZuK
VdnNkVz3ka8pFPU9YMxhK2hC3u0R3CvL76WieI6sgJGNSf1SzMCTk6EYjTyJIsTM
bJFwhk37GQSivO2bmydiKBlH7mVbJ6GhYvzGvk7VfUjB3kDwLaQa+yXGZqdzUQjf
sSKoJbB1uuj22lJWhi3zn8HhRQcksz43w9e0yR9NPe5e10NIokHSk7hKXY91IMFZ
E0Dy7sV0wEy9ic2+bKgw0zXGVAWZiLa04lp8a/gBQ+1h5GuQo3+8zIUwMKpBJICX
ylnERNwSuefhpPUHIUZjYzdMQNwqYcWkXCCMIT926tvRpyMw9kRLAg8DPJFWG8Ki
uL75TvPB4AWiCsbQXKvRsXhQYJHcFen6iELYHnpT62xY7bLYXyYa/0WD3okHBMgR
+kkEwnZGwtiA8FCGgx+vwg42PvxOmZ2Y0FWJAjMEEAEKAB0WIQSz8kadeNeL0J02
bzfJQDXCG08q6wUCXjqBngAKCRDJQDXCG08q6+b+D/9GwnqIgLnHPpAZi4Tm694o
7qgUwHd21sv8SgYYN6YYLwsW5yGrpCdN2gAJDhfr1y++vCpwVwWq1AT0buHTogJB
BuptHunlMIa8budtadb/rU/+0ATSYEpUU6wmp1uNh6uubVMaQZJq2qU5ylhP1P8U
EfWeKyAxgJW8sQ/+8l53+P0KCKO1GKrmP4IcG80Aevqnthi3ZDI7DVwpF2icJDqf
YeALlW5BEInhnzP/E6uXut1VaTn8+rXZS8p8ZWCTNI6qqJ7wdkE8W64wUatz/IDw
AYamV8szi58eoIgrUsT2MIzBXYyJdpbMR3Bvt8kX9oFEjsHpDk3cR7CZOKjm/vv4
zbXYK8tUVdhwgFe6KRA9pEqVIMx7MFyvqyZprxQMParxeRZJkfJZwnpATte4Kx/7
VEMPulrvksalefE31bVVInmyeYWAmpR1lT5wlXCMRi3GHVbwupWKOdj4uZlKCZ42
2uPcjJTZ9aphUzrQ7hYfNXFuoPshPwfdvnYaPL6G7zw7N3TSk2zCQdNRzcn81Ngk
3oCzMHDb0WbOlPOIbV6bFZ/Cbb46iUvRUW1jA6OJmGIaVIoG/Q5tjIwjl9NBgp8J
pIk5ZXxDheibLo+/4LN1j9sj6qrMF/4WNwciCCx1/3uxWtC7iG+f8pLBzqJdgQBx
E8PAf9pHCucmQeGIpCJigbQmQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1QGdt
YWlsLmNvbT6JAlQEEwEKAD4WIQQALAspIOar71EO/k/hynOjyVlOJAUCXklqVgIb
AwUJB4ae8gULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRDhynOjyVlOJIAyD/9K
X9113oKqqvSQynT9iE0QUKF2QX9P1gtiswRpuwJ2dGYeZ1p/SV7zEXyY03+T6q4A
5ok7WGRqbHUKAFsdVid/aLEg5E/BcpBkODakA0aGutbUMLymQav/FwNCYsMEkWYI
4FP8t2ViyiriA1aCkvGv/U/EzIXl+DgwFdM/NciMr9U9BfPTrE5Rzqkj24ipSrkA
b0BweRmdn/q9t51OzUuf+z6j1QC1US+k0oqcQ+Ol1UrbDGnNnOurWWGRkWFHa2X2
YuGmyZFY/4YNHV1oxWOpnFgt/7/oY4rH7qLdNRT/gC/+yvGxB+IEo6srfeS/KVH8
TrHC7HR4fMs4opsJtjwqCUISZNZXkye7unhix5DZgdjtdN49b4tjAhpDfwVnjdsj
syuoeN+/LRXNlQl6mr3U279nY6pqirLgQQ8vXmQKhkrDhu3YRiq6tJaZOD/H9gPG
kFaW89lobJIgnx9xcKVNphPzHEwa8dSLExAPRWWdYT6y+yHdrDuCcBIkMv+nSVqS
PuWb0Tz6g/Al6KzJ96GsyHEiK4prha62+NeZM4rmLAJxsLZgVfBVTePSEouWtQLj
Q6n4SHNRLChrismhJsu4phySmMRETcg7JcxNNR2ibK/CTwOdSlndFB/Mx+ikHGhJ
CLMBty26SHzX63bKZ0erMjycgeQCIdiRAs2/y+dXArQnQ2h1bi1LdWFuZyBIdSA8
Y2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc+iQJUBBMBCgA+FiEEACwLKSDmq+9RDv5P
4cpzo8lZTiQFAl5lgJACGwMFCQeGnvIFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AA
CgkQ4cpzo8lZTiQ5Hw/8CSSE68QLdb0S8ea/kH7c1arnIYLCX6hJKuc8h8v5feE2
piwhM6BWMQ6FsblLz1KIeqM67UxnuP7umgdtLM2t5xJ6aZXECMX0j0Xg8X/SqDzD
bpt1qtXxVZ2klJIk34x9sRS4D0WJf6+ISkzihrYp1KgmB9h2acS/kBmu/eaEbh3q
kxNIoyl8AZLIfzQKRl0oxxg2QVI855yEnp9w1VwAVAUIQCfw7FSh20Hcc0aVS5Sy
kaszlBeeh0lHucApbR1a0kMi4+553SBMOy+CqSB9j6PsZdcLJJLqrGFg2ASNTXms
mUTS4XN4rmda3MDVgcwKqwgsKJ9i5mY+JLgSL9jbizTE9k1B6Q+Fe2KjCjUoaOlK
LZpHTLXeDILVZLIQjeeyc9o4EeTfLDxyyyXH2MjV5gEUsBJP8o/7Kv6pPcDCOrIg
GxVYsX9pxjX7Pi5mO+aB0jx6RSe35GbY2PiNaxeXZqDxlmAWuMTkKIgXDrutpmMh
mKf2L/YxKhvoYyBfRDIPvPwCsf1tyZNgGUbbChAsD+5cb+vdOAMwGGNvXXlZhVGM
iNlrFTUHwz5GppYX9ea9/uVLJOTphhu3R7PEvMkzNSe7e6T6lr0szg776UifPlHK
jikNgcT4omLFQIWwsd5/HudtxkgN0q2aheV2oBolY6+fYrjEAZ05hxJQSFqJbUa5
Ag0EXQjz1gEQAM0JrftZTDPvIypnxOwgk+9Qs3h6CwQzBTqRn4lZnFJY3A5V9Ju/
Fj4PeK4hwZqBSEN2WF98UQGokckyH85vDwpEsEE7WUeB9WJ7eIGDLtn0bGiEKC6y
OrubF4O6ItJWaWvYVX/WmzcVqZ1CMj9V4jvuSvxqdEGZENm0A+nT/okcfnWWDMYP
OJ5j0vc7zYIlGXBHRbke1mgrmUW/SvHBppvUli4JoWunYccUOzZ4l7PTXzutVgVk
3LA6Vja13A32FgNeNCigKWoLdwEFeHs9nKuS2hrSRKxiP5wTAxk2WotL48pFuBp9
HzSyJJ+ro3D2IFGSnT6GOM8VBTXo8FmY441chfeQFIhJ1wN5NQP5zuRmnUI4Qgp3
lgbCOIUFuwb32L4JsdonrTcLtC78dz650pbvmpmi1pUsXJ38iUL2Y2GUTI2bIWr5
tfYCvA3RH6J+eVtWqfJEgXkAtWmkeoIpbNhTalbcyqhmzlsNfbQe4ZTcYaJcX+4B
qlcssY/HE9h7LbCcdUY85EJ1iXhHUYtZ7sGb4JYmqczXTszf/0SN1dJOkuF0UetO
KuplYmtQzJswjgaiKTQ4Nv6Ta7GSHtkD3KboHx4cF4XcYIKgNOyB6uA8hSVf7fJ3
Xx1wcyb9YJWTMZyNXwebuXVLYegETtZ8i+oUPziRks8HMzfH3ucKT6bFABEBAAGJ
AjYEGAEKACACGwwWIQQALAspIOar71EO/k/hynOjyVlOJAUCXghigwAKCRDhynOj
yVlOJOU8D/9gt0qC+WwZjPFZrNLJIDa+BxTJ8bl7/Z09MppFMkx4MGZlVeERIayL
E46/EdfOoFphIv8l5R/7w9hjOlOB/zIHZAoJcE06nTgyddvSgquBhoP8x9Qm+L/K
8efJFdYarm02+oISZJdaMQId9W3wxbimr47xdh0b0AfPgyevQTM+U+P2fp8L70OD
RfqbB3w6msvrtHMnRnDMmpMthBVb5mB5mgx3qojw3SGalSpd/8RxwwMOyZK7fxzG
TPg7C8uZgu5VkBvFBuA6FxhuwTXk3/GeKTgXLqf46Te1aTqNy+DOpufMUf1xj1GN
NzHY5xBVSlxe6ZivvM1OqfoZqHPJTNrCJm/iZRUi3n410Jq8IiuGTy0KBzGfcNZN
LpnQwmcgCizcVrOqQgyYdR2d8JO683URlpM7jnsvKq+19bHQgENW8H2KvEQ8MxKf
Ha6HS5Nloe40YBJWaapk2Mh22/ZCvfcXSk5TdcHAp3reFz/DStWKip4GrrgzOBss
GgxxoeQrUEgz/5n5nzDDId00HaS63Nj6bvzgxd+AVDHq6ibZ6EBEK7Su6AMoBIX6
plOUNnbY35FCJVh8ITNckb5oMT/oDK/SsWel7Y0259scoJoPNdzMNxXxrwiNDOeB
XayVYkXomwPYGsJvyyyM9OApavoQ/85ixTOaMdiOypkawVlv3fmRBQ==
=ISiD
-----END PGP PUBLIC KEY BLOCK-----

--YXCgAdvdBK1pCYWW--
