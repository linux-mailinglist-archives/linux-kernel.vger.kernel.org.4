Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FDC67A53D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjAXVu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjAXVuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:50:54 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C2F49969
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:50:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h12so11257485wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JdGIK9fuLzovgW08Fh17fW35j9gyLSLJ6qwS42nXVqM=;
        b=cQpPIiBTzpS8cMDYtf4PjumELI5IzfBWpNIjtFDJeenn2/l1Iu53R4EWUmWUsQRyha
         Ex3nZ2dLgPHCTGrtrAuMilERJt8/AYsDBa7/2265hPkti3LZZ5whIwBwNZzCVlXDcD4K
         zKtHdVr3rRjLt/RdtViPFECo6koBSfkipGbht7JrMa7WtJaF4N+eD8R5AxA9CUDxD1GB
         vmEyv2rKPIzzAKu0tHaI07qBx3RVf0CJq0oYdpseHchqHhKTTjzcVoRg4t0Bi7ie1ODl
         HOpx7vEQ11C7gkzkUJxuFWIPcn1VlHtfVY+dcOCEl3nDT6oQ1vnLTPi0DN/N5JB4eaFm
         z2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdGIK9fuLzovgW08Fh17fW35j9gyLSLJ6qwS42nXVqM=;
        b=sJFhS/wa9EwcnHuOaiGAOcMSakvgDd8milY0IMBcFwt24MG9htObt90D2y3O0utZf8
         JOhNFawBALIlYok4bjEDvrGpDIR0wL17y7yejk97m5JBTGqVafyAxb/BKF6ATwqOS0sx
         yU2ZBvSkNMxQMYX313hlzR2nMUx6EDp0rYuS7orT/HvjSWtcC+mM+uUPlnjyngCIS8FD
         u+REWErawjZnEJUNGBKlIGYrn6vPhirA84h2ShSY9ulBlkr7AYZ4U9JqeoFiD5FzDfX5
         /rrPt9wtwFQNZjy2Zz1JvQV/UaOhtY4lUzFmjcCb7N5aVuiMfXElGhFmitbnhUPcTEVu
         IG2A==
X-Gm-Message-State: AFqh2kqie/7XCs2TEIJO2eUrRIRzJc1XKcSbgecbope3MJsn5uLXtPJm
        uRFKiNu0jQu7I9Jt89hj1S+iHtCZBl6SL1BvNheLIg==
X-Google-Smtp-Source: AMrXdXsTeUF6GDOjMGYSnhvd1fkdYuuWLfRK1pvF4sBCp7ZE9wBl5fyVrgjmB81WZzXz4NCjIiDsaWFLA+vXVhdvqRU=
X-Received: by 2002:a05:6000:1d9b:b0:2bc:aa47:bf7a with SMTP id
 bk27-20020a0560001d9b00b002bcaa47bf7amr765242wrb.343.1674597051614; Tue, 24
 Jan 2023 13:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20230120153706.20388-1-mike.leach@linaro.org> <77f9eab5-4fb2-cf96-9628-2a816d519d61@arm.com>
In-Reply-To: <77f9eab5-4fb2-cf96-9628-2a816d519d61@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 Jan 2023 13:50:38 -0800
Message-ID: <CAP-5=fWNT9XXMN+97TcprxWA+FRJpAy4T=XC9RHrOdKfcKi8_w@mail.gmail.com>
Subject: Re: [PATCH] perf: cs-etm: Update decoder code for OpenCSD version 1.4
To:     James Clark <james.clark@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 7:47 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 20/01/2023 15:37, Mike Leach wrote:
> > OpenCSD version 1.4 is released with support for FEAT_ITE.
> > This adds a new packet type, with associated output element ID in
> > the packet type enum - OCSD_GEN_TRC_ELEM_INSTRUMENTATION.
> >
> > As we just ignore this packet in perf, add to the switch statement
> > to avoid the "enum not handled in switch error", but conditionally
> > so as not to break the perf build for older OpenCSD installations.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index fa3aa9c0fb2e..48e7121880a9 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -604,6 +604,9 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> >       case OCSD_GEN_TRC_ELEM_CUSTOM:
> >       case OCSD_GEN_TRC_ELEM_SYNC_MARKER:
> >       case OCSD_GEN_TRC_ELEM_MEMTRANS:
> > +#if (OCSD_VER_NUM >= 0x010400)
> > +     case OCSD_GEN_TRC_ELEM_INSTRUMENTATION:
> > +#endif
> >       default:
> >               break;
> >       }
>
> Checked the build with both old and new versions of OpenCSD and it's ok:
>
> Reviewed-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
