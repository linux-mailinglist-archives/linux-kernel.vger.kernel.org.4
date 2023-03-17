Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C3F6BE121
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCQGSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCQGSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:18:31 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF013A225D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:18:26 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230317061822epoutp0410b88836181cb091b54f21357da14ecd~NIHAkjM1o0877708777epoutp04m
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:18:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230317061822epoutp0410b88836181cb091b54f21357da14ecd~NIHAkjM1o0877708777epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679033902;
        bh=8CbruO9QHy1Pi24lHSIWndXgjvSY156tnMjPXjFB46E=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=quuI+KnbczsLDz0oVGM7f/1++COyMzzbClQCsSuZ1o2RmHc+6opUyE+FQ1H+CIPDs
         UddHzf1AhgPJpjEO6PLQGU7p3CQHYPjEMHg4ung7mwxevbZ7HxLMS20d6iNmTgWh/G
         4aTYH/94oVf2GwuS+RBa+HA8AHzlV6PKDz8wfpQo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230317061821epcas1p42ea8c5f50cc665f7f9ce987b81d7f336~NIHAClPJz1242612426epcas1p4U;
        Fri, 17 Mar 2023 06:18:21 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.250]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PdDTT17plz4x9Pp; Fri, 17 Mar
        2023 06:18:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.17.52037.D2604146; Fri, 17 Mar 2023 15:18:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230317061820epcas1p2721102e23224fcccbc2c69c2f14fd1c3~NIG-Zc9H42012920129epcas1p2H;
        Fri, 17 Mar 2023 06:18:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230317061820epsmtrp13c9bc2e184633ebb9d50f28287c0169a~NIG-YrXQ50057100571epsmtrp1h;
        Fri, 17 Mar 2023 06:18:20 +0000 (GMT)
X-AuditID: b6c32a37-7cbfd7000001cb45-9c-6414062dcdd1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.71.18071.C2604146; Fri, 17 Mar 2023 15:18:20 +0900 (KST)
Received: from youngjingil02 (unknown [10.253.98.199]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230317061820epsmtip2ae9439847795bd4e88e282b6a952c9d7~NIG-Lo0SC0912909129epsmtip29;
        Fri, 17 Mar 2023 06:18:20 +0000 (GMT)
From:   =?ks_c_5601-1987?B?sea/tcH4L1N5c3RlbSBDb3JlIExhYi4oTVgpL7vvvLrA/MDa?= 
        <youngjin.gil@samsung.com>
To:     "'Eric Biggers'" <ebiggers@kernel.org>
Cc:     <agk@redhat.com>, <snitzer@kernel.org>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Nathan Huckleberry'" <nhuck@google.com>,
        "'Sami Tolvanen'" <samitolvanen@google.com>
In-Reply-To: <ZBNjcA1feNWUxvaW@gmail.com>
Subject: RE: [PATCH] dm verity: fix error handling for check_at_most_once
Date:   Fri, 17 Mar 2023 15:18:20 +0900
Message-ID: <000001d95898$456301d0$d0290570$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGQOF3WKzL6/erBkz5jz0bMtah/BQHnLikgA3pH1sOvZa6BUA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmga4um0iKwZVLbBbrTx1jttj7bjar
        xdo9f5gtLu+aw2ax+fAnFoulK96yWmz5d4TV4sQtaQcOjwWbSj02repk83i/7yqbR9+WVYwe
        nzfJBbBGNTDaJBYlZ2SWpSqk5iXnp2TmpdsqhYa46VooKWTkF5fYKkUbGhrpGRqY6xkZGemZ
        GsVaGZkqKeQl5qbaKlXoQvUqKRQlFwDV5lYWAw3ISdWDiusVp+alOGTll4Kcr1ecmFtcmpeu
        l5yfq6RQlphTCjRCST/hG2PGlYt32Qs6FCp2zsxrYNwn2cXIySEhYCKx5GUDYxcjF4eQwA5G
        iTtX57NDOJ8YJTqetDFDON8YJT4cmsUG0zLv3h2olr2MEqsvHIWqes0o8WvDOiaQKjaBDInO
        +btYQGwRAS2J3jlPWUGKmAVeMUq8ed4HNopTQFPi5PRuRhBbWMBTovHlRLA4i4CqxLYJ84Bs
        Dg5eAUuJK0v8QMK8AoISJ2c+AZvJLGAksWT1fCYIW15i+9s5zBDXKUjs/nSUFaRVRMBJ4vr7
        IogSEYnZnRDfSAjM5ZBo6Z/FCFHvIjHlz2ImCFtY4tXxLewQtpTEy/42doiGdkaJFQ/nMEI4
        Mxgl/r6/zwpRZS/R3NoMDRdFiZ2/50JNFZQ4fa2bGWI1n8S7rz1gF0kI8Ep0tAlBlKhJXJn0
        i3UCo/IsJL/NQvLbLCS/zULyxAJGllWMYqkFxbnpqcWGBcbIUb6JEZx8tcx3ME57+0HvECMT
        B+MhRgkOZiURXt6fwilCvCmJlVWpRfnxRaU5qcWHGJOBoT2RWUo0OR+Y/vNK4g3NzCwtLI1M
        DI3NDA0JC5tYGpiYGZlYGFsamymJ84rbnkwWEkhPLEnNTk0tSC2C2cLEwSnVwDTNQna1V6Co
        +N4JW7rvNGRwT19w9LJPzQoGyfcNZlNYXG9nL9VyfKF++eDhBdp5KyTLVc7ZTBdxXe9f2LE/
        a8OVr35Xl2exOMuXSd1i1+Rd/DTjZdNF5esd/KkPdRPLbqfc5dMuObhCdZe/7YyeUp2TDyfP
        XKrdc3HdrtInTa/kMwVN73/06RBdPM3flsXXJ26t6P69Ocp91360SF8y/dFxoSXygKrn2oSq
        aOslkTs5jimJ3fiWsib4+LuarOMHtrTKMU/vL0iT81rTy3eEx9PL6k7SvDdfjLaHfqqdVr7w
        gJnYda4iRpXMZsYqx0tnrL6rpv9yXH7b+p6iOluRcr5/5xfXhlJLHv/K7ltKSizFGYmGWsxF
        xYkARgRQwnUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJXleHTSTFoPmXtsX6U8eYLfa+m81q
        sXbPH2aLy7vmsFlsPvyJxWLpiresFlv+HWG1OHFL2oHDY8GmUo9NqzrZPN7vu8rm0bdlFaPH
        501yAaxRXDYpqTmZZalF+nYJXBlXLt5lL+hQqNg5M6+BcZ9kFyMnh4SAicS8e3cYuxi5OIQE
        djNKbGzZyw6RkJH4M/E9WxcjB5AtLHH4cDFIWEjgJaPE08taIDabQJrEn2NPGEFsEQEtid45
        T1lB5jALfGCUWPlwExtEwxpGiR+fkkBsTgFNiZPTu8EahAU8JRpfTgSrYRFQldg2YR7YLl4B
        S4krS/xAwrwCghInZz5hAbGZge5sPNwNZctLbH87hxniTAWJ3Z+OsoK0igg4SVx/XwRRIiIx
        u7ONeQKj8Cwkk2YhmTQLyaRZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQI
        jiYtzR2M21d90DvEyMTBeIhRgoNZSYSX96dwihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n
        44UE0hNLUrNTUwtSi2CyTBycUg1M5xVu33V6srvolvqh5//WT6mUr1ur4LNPSc2GZTtnQs1a
        rSm5wdckGO/MYH6WZ3T3UfOy3mQ7M+OkQFV3mw5LMTaNHYI7t2eFXE3pOelnxlDhan/+4F/G
        JXNXZpRc3M9x7M0/Te6pKvuXdrRJ1AbUMS8TMerb5buIzSDMcfKGpbYr//naF5QulG5cnnm/
        bEFMdvXUDUf3vFko7WlXe73gzELrdfqvI3QFcv79mJfuPcdF2kv13v//Dh5NlSeDJKY833m8
        fM/GCzxSk7bx6i7qDKkUfOfZL1Kesv14HztL3eOTPzimvZ4ullnybHXjJ19R2R8HrTw/PBZ7
        qVDBom7ilJMqF9t6+1WmZoaTn7USS3FGoqEWc1FxIgAZ4Xk4FQMAAA==
X-CMS-MailID: 20230317061820epcas1p2721102e23224fcccbc2c69c2f14fd1c3
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230316031936epcas1p1ebd93477dcf3bf9ab1640306dd1da8ff
References: <CGME20230316031936epcas1p1ebd93477dcf3bf9ab1640306dd1da8ff@epcas1p1.samsung.com>
        <20230316031842.17295-1-youngjin.gil@samsung.com>
        <ZBNjcA1feNWUxvaW@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,
Thank you for your detailed feedback.
> Hi Yeongjin,
> 
> On Thu, Mar 16, 2023 at 12:18:42PM +0900, Yeongjin Gil wrote:
> > In verity_work(), the return value of verity_verify_io() is converted
> > to blk_status and passed to verity_finish_io(). BTW, when a bit is set
> > in
> > v->validated_blocks, verity_verify_io() skips verification regardless
> > v->of
> > I/O error for the corresponding bio. In this case, the I/O error could
> > not be returned properly, and as a result, there is a problem that
> > abnormal data could be read for the corresponding block.
> >
> > To fix this problem, when an I/O error occurs, do not skip
> > verification even if the bit related is set in v->validated_blocks.
> >
> > Fixes: 843f38d382b1 ("dm verity: add 'check_at_most_once' option to
> > only validate hashes once")
> >
> > Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> > Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> > ---
> >  drivers/md/dm-verity-target.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/dm-verity-target.c
> > b/drivers/md/dm-verity-target.c index ade83ef3b439..9316399b920e
> > 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
> > @@ -523,7 +523,7 @@ static int verity_verify_io(struct dm_verity_io *io)
> >  		sector_t cur_block = io->block + b;
> >  		struct ahash_request *req = verity_io_hash_req(v, io);
> >
> > -		if (v->validated_blocks &&
> > +		if (v->validated_blocks && bio->bi_status == BLK_STS_OK &&
> >  		    likely(test_bit(cur_block, v->validated_blocks))) {
> >  			verity_bv_skip_block(v, io, iter);
> >  			continue;
> 
> Thanks for sending this patch!  This looks like a correct fix, but I have
> some
> comments:
> 
> * Using "check_at_most_once" is strongly discouraged, as it reduces
> security.
>   If you are using check_at_most_once to improve performance at the cost
> of
>   reduced security, please consider that very recently, dm-verity
> performance
>   has significantly improved due to the removal of the WQ_UNBOUND
> workqueue flag
>   which was causing significant I/O latency.  See commit c25da5b7baf1
>   ("dm verity: stop using WQ_UNBOUND for verify_wq").
> 
> * I think your commit message does not explain a key aspect of the problem
> which
>   is why is verity even attempted when the underlying I/O has failed?
> This
>   appears to be because of the Forward Error Correction (FEC) feature.
So,
> this
>   issue is specific to the case where both FEC and check_at_most_once is
> used.
>   Can you make your commit message explain this?
Okay. I will update commit message.
> 
> * This patch does not appear to have been received by the dm-devel mailing
> list,
>   which is the list where dm-verity patches should be reviewed on.  It
> doesn't
>   show up in the archive at https://lore.kernel.org/dm-devel.  Also, I'm
>   subscribed to dm-devel and I didn't receive this patch in my inbox.  (I
> had to
>   download it from https://lore.kernel.org/lkml instead.)  Did you receive
> a
>   bounce message when you sent this patch?
I am not sure but I received message from googlemail.com as follow
"totte@google.com because the address couldn't be found".
I will try to send v2 patch exclude totte@google.com and check the mailing.
> 
> * Please add 'Cc: stable@vger.kernel.org' to the commit message, just
> below the
>   Fixes line, as per Documentation/process/stable-kernel-rules.rst.  This
> will
>   ensure that the fix will be backported to the stable kernels.
Okay.
> 
> * "Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>" does not have a
>   corresponding Author or Co-developed-line, which is not allowed.  Did
> you mean
>   to list Sungjong as the Author or as a co-author?
I created a patch through an internal review with Sungjong.
I will change the tag to "Reviewed-by"
> 
> * No blank line between Fixes and the Signed-off-by line(s), please.
Okay. Thanks. I will send v2 patch soon.
> 
> Thanks!
> 
> - Eric

