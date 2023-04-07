Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4686DAAA4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbjDGJII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbjDGJH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B1093C4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680858431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXnKb64GaarQGbssPkA34biCMXryXalt9+iVZ6jvN4s=;
        b=Ot5D5RYq7PkZswQgQ+AU0N7hDq0IMY2nUmoXAP5N5W/6vlFTpIRcNWIskIa0fpTCiTtEuF
        j7pL02EMNdu6CV+oXPfBKlaaTOSvyDJmzTsQHdt/dkDnke3w5zoeZ4tnyiaZyb/215GHZs
        yxOh705cD1pIUd1hoFxzog2QmNLFhDU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-0_s5caN0NCajon4ICdulFQ-1; Fri, 07 Apr 2023 05:07:10 -0400
X-MC-Unique: 0_s5caN0NCajon4ICdulFQ-1
Received: by mail-ej1-f70.google.com with SMTP id h20-20020a1709070b1400b009333eaeb2b3so1350126ejl.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680858429; x=1683450429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXnKb64GaarQGbssPkA34biCMXryXalt9+iVZ6jvN4s=;
        b=XvmBtiseDcT1W8Xiomd2tMIGAAd4FMn7/IDgMQ7dlv7jiLcBl1CVnCyg/sDPvKfzg7
         9XUpMnLAUErYK981QgKaCkpvl7UDPBzpN1G5V2bFyPqvbRsTL+ap6S5d0kcESbDz4Juz
         L8/BepoI3KOZ13cFXbZLBMyDG623zLsk7ew+X+fKgtoOG4+oF/jDt0SPGunQf3+P5Efi
         tpwtnCLnKyxOk+kfseaL5ZG8a9TC+WBsWtOjF3XeMjtIKiu4jazXAMjCR4gajJ3IBKMp
         o3hF52ArykEu/oPQjDt/esU7Qs0Vp+nBZyWHAqGrzGpuQaHip7OQ+Q1NWTtYTxkL3hhg
         TVYQ==
X-Gm-Message-State: AAQBX9fsl+MXjGYD2lMoFpUr6jPhl65N2sONc01lFZ3+Q/qWI2oQsgSp
        KNvGhp6xQz6Q/ySuJJ4odflzwi8YS0f56yW7v1qW5kpzm7IFldZaBZKrd10DDCu2qIeGRXXtUzA
        l/Z7ynyhjhF1zshvnxhtMfHUwRZ9qChXuKt3DoZyhQc3CvUqXqsB70w==
X-Received: by 2002:a17:907:6e88:b0:947:556e:ed3 with SMTP id sh8-20020a1709076e8800b00947556e0ed3mr830053ejc.11.1680858429275;
        Fri, 07 Apr 2023 02:07:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350YdOW0qwj1qb7BHdZwRKNc+uSWFl5YKzWm+tNRh3geJ6Es3NIN2HONYXvWtvhcS3IPu9hjnamNynUhTpWPOJpM=
X-Received: by 2002:a17:907:6e88:b0:947:556e:ed3 with SMTP id
 sh8-20020a1709076e8800b00947556e0ed3mr830039ejc.11.1680858428873; Fri, 07 Apr
 2023 02:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230404084701.2791683-1-ryasuoka@redhat.com> <20230405010403.GO3223426@dread.disaster.area>
 <CAHpthZoWRWS2bXFDQrB+iOz7AA_ZLGJKmytHjN582VaWQ_TRwg@mail.gmail.com> <20230405230415.GT3223426@dread.disaster.area>
In-Reply-To: <20230405230415.GT3223426@dread.disaster.area>
From:   Ryosuke Yasuoka <ryasuoka@redhat.com>
Date:   Fri, 7 Apr 2023 18:06:57 +0900
Message-ID: <CAHpthZrvhqh8O1HO7U_jVnaq9R9Ur=Yq2eWzjWfNx3ryDbnGPA@mail.gmail.com>
Subject: Re: [PATCH] xfs: Use for_each_perag() to iterate all available AGs
To:     Dave Chinner <david@fromorbit.com>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

> On Thu, Apr 6, 2023 at 8:04=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
> >
> > On Wed, Apr 05, 2023 at 05:04:14PM +0900, Ryosuke Yasuoka wrote:
> > > Dave,
> > >
> > > Thank you for reviewing my requests.
> > >
> > > > > for_each_perag_wrap() doesn't expect 0 as 2nd arg.
> > > > > To iterate all the available AGs, just use for_each_perag() inste=
ad.
> > > >
> > > > Thanks, Ryosuke-san. IIUC, this is a fix for the recent sysbot
> > > > reported filestreams oops regression?
> > > >
> > > > Can you include the context of the failure it reported (i.e. the
> > > > trace from the oops), and the 'reported-by' tag for the syzbot
> > > > report?
> > > >
> > > > It should probably also include a 'Fixes: bd4f5d09cc93 ("xfs:
> > > > refactor the filestreams allocator pick functions")' tag as well.
> > >
> > > No. my request is in the same code area where syzbot bug was reported=
,
> > > but it might not be relevant. A kernel applying my patch got the same=
 Oops.
> > >
> > > I'm indeed checking the syzbot's bug and I realized that this small b=
ug fix
> > > is not related to it based on my tests. Thus I sent the patch
> > > as a separate one.
> > >
> > > > While this will definitely avoid the oops, I don't think it is quit=
e
> > > > right. If we want to iterate all AGs, then we should be starting th=
e
> > > > iteration at AG 0, not start_agno. i.e.
> > > >
> > > > +                       for_each_perag(args->mp, 0, args->pag)
> > >
> > > I agree with your proposal because it is more direct.
> > > However, as the current for_each_perag() macro always assigns 0 to (a=
gno),
> > > it will cause compilation errors.
> >
> > Yup, I didn't compile test my suggestion - i just quickly wrote it
> > down to demonstrate what I was thinking. I expect that you have
> > understood that using for_each_perag() was what I was suggesting is
> > used, not that the sample code I wrote is exactly correct. IOWs,
> >
> >                 for_each_perag(args->mp, start_agno, args->pag)
> >
> > would have worked, even though the code does not do what it looks
> > like it should from the context of start_agno. Which means this
> > would be better:
> >
> >                 start_agno =3D 0;
> >                 for_each_perag_from(args->mp, start_agno, args->pag)
> >
> > because it directly documents the value we are iterating from.

OK. I'll update my patch, run a compile test, and then send again as a
v2 another thread


Thank you for reviewing.
Ryosuke

