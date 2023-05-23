Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038FC70E673
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbjEWU3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjEWU3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:29:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E8130;
        Tue, 23 May 2023 13:29:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CEA663497;
        Tue, 23 May 2023 20:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91306C4339C;
        Tue, 23 May 2023 20:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684873786;
        bh=3zormi991DJH+Ol8uhpUBr0tm4WKud04qZ9kQu+6tBc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=XxLtyN2zRhNjNC5UpZMBju/c1LzM0hSW9dlYTi5yn82LF2zUZTN+lUd3eijnXCXLF
         YorZJMah4CLS9xZevcNRQop+uYHisQBar0e3J1X2hKYtuURYZO3w8b5jK8exN8JLjG
         wO1KIucQ4ia5mXd1fbffiIqJytOWRo1tFUX1AMOxaXxdHwWmNVY4maCgMuUDaIgjJG
         rgKJ1+cSB9dn6STLlUn81hW7BUYB/XZcQqrUzduY+JgqpllIgSXPQqzvHjf8szgc6B
         TPeC7bfRL1Qysv2y7+raePTNEcPLqHyKDuH6Ik9JFkPAxqF/rphBdMkIIF9g8KfAea
         +CODsfSON8dTg==
Date:   Tue, 23 May 2023 13:29:45 -0700
From:   Kees Cook <kees@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D=5Bnext=5D_scsi=3A_lpfc=3A_Replace_o?= =?US-ASCII?Q?ne-element_array_with_flexible-array_member?=
User-Agent: K-9 Mail for Android
In-Reply-To: <3d298c36-cdd8-62bd-2fef-c2ce63e662ef@embeddedor.com>
References: <cover.1684358315.git.gustavoars@kernel.org> <6c6dcab88524c14c47fd06b9332bd96162656db5.1684358315.git.gustavoars@kernel.org> <yq11qj8nhy7.fsf@ca-mkp.ca.oracle.com> <202305231031.C9E6124@keescook> <3d298c36-cdd8-62bd-2fef-c2ce63e662ef@embeddedor.com>
Message-ID: <9ECC5C8E-D8E1-4444-BC47-D49FE015144D@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 23, 2023 12:46:54 PM PDT, "Gustavo A=2E R=2E Silva" <gustavo@embedde=
dor=2Ecom> wrote:
>
>
>On 5/23/23 11:31, Kees Cook wrote:
>> On Mon, May 22, 2023 at 06:02:21PM -0400, Martin K=2E Petersen wrote:
>>>=20
>>> Gustavo,
>>>=20
>>>> One-element arrays are deprecated, and we are replacing them with fle=
xible
>>>> array members instead=2E So, replace one-element arrays with flexible=
-array
>>>> members in a couple of structures, and refactor the rest of the code,
>>>> accordingly=2E
>>>>=20
>>>> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
>>>> routines on memcpy() and help us make progress towards globally
>>>> enabling -fstrict-flex-arrays=3D3 [1]=2E
>>>>=20
>>>> This results in no differences in binary output=2E
>>>=20
>>> Applied to 6=2E5/scsi-staging, thanks!
>>=20
>> Martin, I think this patch is not right -- can you drop this from
>> staging for the moment?
>
>Martin just took patch 1/2, which is correct:
>
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/mkp/scsi=2Egit/commit=
/?h=3D6=2E5/scsi-staging&id=3De90644b0ce2d700a65579ac74ff594414e8ba30f

Oops, yes, I thought both got pulled=2E 1/2 is fine=2E :)

-Kees


--=20
Kees Cook
