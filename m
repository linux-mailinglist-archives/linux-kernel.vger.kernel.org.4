Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6626E7123
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDSCcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDSCcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:32:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4986558D;
        Tue, 18 Apr 2023 19:32:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sz19so20945676ejc.2;
        Tue, 18 Apr 2023 19:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681871570; x=1684463570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0TaPgyYc5LCwXFDaFlL9r5C+qVCPDLXFVp+9NMWeidw=;
        b=r5kzeAunCjJuN2Dq4kSAOdxDGwFe5Sxk2kM2h2kqCOT1MZEu9XhvXWzHwnZgl3Pqmf
         PZPmZ0RcILRmB0BNOLaVht5hfhy0f9w9/7a0PRcqV+U2zcDn24lCffCXG7OXQVce/Qgo
         c4npiJj3V272byyhCGn+PsbBU+0FKAmlAcdqMCHm0aRxRd6AynWevFX3o88/ZgOZBGqN
         XABLcJuYJXHX2bu9SHr29bW6C+eLneXwtxMxj2bAIm0vx2RiNn2RVhS70HmpUmbWa/TX
         c+mEvxzl9nWH/YVOOR9+t7ccsEwCkCE9EDmF8aMC3/o4cZMqtAjdCsSrYe2xDEVuZmmL
         wQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681871570; x=1684463570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TaPgyYc5LCwXFDaFlL9r5C+qVCPDLXFVp+9NMWeidw=;
        b=fxtCyo/9dXdvNpLWFuvcc6o+xvmsKV10cMD/FQji7OCk+05M3kq7vhzCsK5o2+DjuS
         znoUcc/yFYNVYt8mWcxVIRamWtS/sghstYAD0JmoJWJj2pD4X8TLYelpacHLLGoybMir
         hoah7yIhW20/nwm4shS+AErZDCTYgxHwtccDMWWTb0/3xwk08ZgmFQXgXbVTQXPo9NKP
         KUkJu7iwOsYhfhAZ87CGUOBBk/PJq8r4+YQl76Ups5klup4HzqecMm2sNwiKxGxEEMrQ
         l0RR0hbTmmpacVkGH8u04xzHbQNDaDItPaEG47fdYQpvB4i5Nyu/5wpmaeKA2GRtPXpt
         qoCA==
X-Gm-Message-State: AAQBX9fiW5tH1mQaVP0NpGSD/6bM96YkddYf9kxK5B5J3FD9Bbzg1yDa
        zyuGS+eR5GYTNZBxekQhZxz9bhdesnqHyTPrVm8=
X-Google-Smtp-Source: AKy350b7eUC/jFKQN19JOsCv+H6gVnpvCzmNKwIp8wPEfKZ7cV7C/opFnmuH3qgLv7kpz1KOniP32bnImOCOHxJe2hs=
X-Received: by 2002:a17:906:57d8:b0:94e:e574:6021 with SMTP id
 u24-20020a17090657d800b0094ee5746021mr11786849ejr.7.1681871570149; Tue, 18
 Apr 2023 19:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <1692048.1681857607@warthog.procyon.org.uk>
In-Reply-To: <1692048.1681857607@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 18 Apr 2023 21:32:38 -0500
Message-ID: <CAH2r5mudRezz-9wcHN+dcZmApeZ4L--CmTpCaaMAL6RDNihZtw@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix unbuffered read
To:     David Howells <dhowells@redhat.com>
Cc:     Paulo Alcantara <pc@manguebit.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Long Li <longli@microsoft.com>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007f50d805f9a73dd3"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007f50d805f9a73dd3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Updated to add Paulo's Acked-by and also attached the other fix. Let
me know if any additional feedback/review/testing results

    cifs: Reapply lost fix from commit 30b2b2196d6e

    Reapply the fix from
       30b2b2196d6e ("cifs: do not include page data when checking signatur=
e")
    that got lost in the iteratorisation of the cifs driver.

On Tue, Apr 18, 2023 at 5:40=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
>
> If read() is done in an unbuffered manner, such that, say,
> cifs_strict_readv() goes through cifs_user_readv() and thence
> __cifs_readv(), it doesn't recognise the EOF and keeps indicating to
> userspace that it returning full buffers of data.
>
> This is due to ctx->iter being advanced in cifs_send_async_read() as the
> buffer is split up amongst a number of rdata objects.  The iterator count
> is then used in collect_uncached_read_data() in the non-DIO case to set t=
he
> total length read - and thus the return value of sys_read().  But since t=
he
> iterator normally gets used up completely during splitting, ctx->total_le=
n
> gets overridden to the full amount.
>
> However, prior to that in collect_uncached_read_data(), we've gone throug=
h
> the list of rdatas and added up the amount of data we actually received
> (which we then throw away).
>
> Fix this by removing the bit that overrides the amount read in the non-DI=
O
> case and just going with the total added up in the aforementioned loop.
>
> This was observed by mounting a cifs share with multiple channels, e.g.:
>
>         mount //192.168.6.1/test /test/ -o user=3Dshares,pass=3D...,max_c=
hannels=3D6
>
> and then reading a 1MiB file on the share:
>
>         strace cat /xfstest.test/1M  >/dev/null
>
> Through strace, the same data can be seen being read again and again.
>
> Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rathe=
r than a page list")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <smfrench@gmail.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> cc: Long Li <longli@microsoft.com>
> cc: Enzo Matsumiya <ematsumiya@suse.de>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> ---
>  fs/cifs/file.c |    4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 321f9b7c84c9..f8877dc91cc5 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -4010,7 +4010,6 @@ static void
>  collect_uncached_read_data(struct cifs_aio_ctx *ctx)
>  {
>         struct cifs_readdata *rdata, *tmp;
> -       struct iov_iter *to =3D &ctx->iter;
>         struct cifs_sb_info *cifs_sb;
>         int rc;
>
> @@ -4076,9 +4075,6 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx=
)
>                 kref_put(&rdata->refcount, cifs_readdata_release);
>         }
>
> -       if (!ctx->direct_io)
> -               ctx->total_len =3D ctx->len - iov_iter_count(to);
> -
>         /* mask nodata case */
>         if (rc =3D=3D -ENODATA)
>                 rc =3D 0;
>


--=20
Thanks,

Steve

--0000000000007f50d805f9a73dd3
Content-Type: text/x-patch; charset="UTF-8"; name="0002-cifs-Fix-unbuffered-read.patch"
Content-Disposition: attachment; 
	filename="0002-cifs-Fix-unbuffered-read.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lgn2vpjg0>
X-Attachment-Id: f_lgn2vpjg0

RnJvbSBhYzEzNjkyODQ0ZjJmYjIzYzUwMzA2NmMwY2IyMzEyNDMyMThhN2M4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBUdWUsIDE4IEFwciAyMDIzIDIzOjQwOjA3ICswMTAwClN1YmplY3Q6IFtQQVRDSCAyLzNd
IGNpZnM6IEZpeCB1bmJ1ZmZlcmVkIHJlYWQKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBl
OiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhi
aXQKCklmIHJlYWQoKSBpcyBkb25lIGluIGFuIHVuYnVmZmVyZWQgbWFubmVyLCBzdWNoIHRoYXQs
IHNheSwKY2lmc19zdHJpY3RfcmVhZHYoKSBnb2VzIHRocm91Z2ggY2lmc191c2VyX3JlYWR2KCkg
YW5kIHRoZW5jZQpfX2NpZnNfcmVhZHYoKSwgaXQgZG9lc24ndCByZWNvZ25pc2UgdGhlIEVPRiBh
bmQga2VlcHMgaW5kaWNhdGluZyB0bwp1c2Vyc3BhY2UgdGhhdCBpdCByZXR1cm5pbmcgZnVsbCBi
dWZmZXJzIG9mIGRhdGEuCgpUaGlzIGlzIGR1ZSB0byBjdHgtPml0ZXIgYmVpbmcgYWR2YW5jZWQg
aW4gY2lmc19zZW5kX2FzeW5jX3JlYWQoKSBhcyB0aGUKYnVmZmVyIGlzIHNwbGl0IHVwIGFtb25n
c3QgYSBudW1iZXIgb2YgcmRhdGEgb2JqZWN0cy4gIFRoZSBpdGVyYXRvciBjb3VudAppcyB0aGVu
IHVzZWQgaW4gY29sbGVjdF91bmNhY2hlZF9yZWFkX2RhdGEoKSBpbiB0aGUgbm9uLURJTyBjYXNl
IHRvIHNldCB0aGUKdG90YWwgbGVuZ3RoIHJlYWQgLSBhbmQgdGh1cyB0aGUgcmV0dXJuIHZhbHVl
IG9mIHN5c19yZWFkKCkuICBCdXQgc2luY2UgdGhlCml0ZXJhdG9yIG5vcm1hbGx5IGdldHMgdXNl
ZCB1cCBjb21wbGV0ZWx5IGR1cmluZyBzcGxpdHRpbmcsIGN0eC0+dG90YWxfbGVuCmdldHMgb3Zl
cnJpZGRlbiB0byB0aGUgZnVsbCBhbW91bnQuCgpIb3dldmVyLCBwcmlvciB0byB0aGF0IGluIGNv
bGxlY3RfdW5jYWNoZWRfcmVhZF9kYXRhKCksIHdlJ3ZlIGdvbmUgdGhyb3VnaAp0aGUgbGlzdCBv
ZiByZGF0YXMgYW5kIGFkZGVkIHVwIHRoZSBhbW91bnQgb2YgZGF0YSB3ZSBhY3R1YWxseSByZWNl
aXZlZAood2hpY2ggd2UgdGhlbiB0aHJvdyBhd2F5KS4KCkZpeCB0aGlzIGJ5IHJlbW92aW5nIHRo
ZSBiaXQgdGhhdCBvdmVycmlkZXMgdGhlIGFtb3VudCByZWFkIGluIHRoZSBub24tRElPCmNhc2Ug
YW5kIGp1c3QgZ29pbmcgd2l0aCB0aGUgdG90YWwgYWRkZWQgdXAgaW4gdGhlIGFmb3JlbWVudGlv
bmVkIGxvb3AuCgpUaGlzIHdhcyBvYnNlcnZlZCBieSBtb3VudGluZyBhIGNpZnMgc2hhcmUgd2l0
aCBtdWx0aXBsZSBjaGFubmVscywgZS5nLjoKCgltb3VudCAvLzE5Mi4xNjguNi4xL3Rlc3QgL3Rl
c3QvIC1vIHVzZXI9c2hhcmVzLHBhc3M9Li4uLG1heF9jaGFubmVscz02CgphbmQgdGhlbiByZWFk
aW5nIGEgMU1pQiBmaWxlIG9uIHRoZSBzaGFyZToKCglzdHJhY2UgY2F0IC94ZnN0ZXN0LnRlc3Qv
MU0gID4vZGV2L251bGwKClRocm91Z2ggc3RyYWNlLCB0aGUgc2FtZSBkYXRhIGNhbiBiZSBzZWVu
IGJlaW5nIHJlYWQgYWdhaW4gYW5kIGFnYWluLgoKRml4ZXM6IGQwODA4OWY2NDlhMCAoImNpZnM6
IENoYW5nZSB0aGUgSS9PIHBhdGhzIHRvIHVzZSBhbiBpdGVyYXRvciByYXRoZXIgdGhhbiBhIHBh
Z2UgbGlzdCIpClNpZ25lZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5j
b20+CkFja2VkLWJ5OiBQYXVsbyBBbGNhbnRhcmEgKFNVU0UpIDxwY0BtYW5ndWViaXQuY29tPgpj
YzogSsOpcsO0bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+CmNjOiBMb25nIExpIDxsb25n
bGlAbWljcm9zb2Z0LmNvbT4KY2M6IEVuem8gTWF0c3VtaXlhIDxlbWF0c3VtaXlhQHN1c2UuZGU+
CmNjOiBTaHlhbSBQcmFzYWQgTiA8bnNwbWFuZ2Fsb3JlQGdtYWlsLmNvbT4KY2M6IFJvaGl0aCBT
dXJhYmF0dHVsYSA8cm9oaXRocy5tc2Z0QGdtYWlsLmNvbT4KY2M6IEplZmYgTGF5dG9uIDxqbGF5
dG9uQGtlcm5lbC5vcmc+CmNjOiBsaW51eC1jaWZzQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2Zm
LWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9m
aWxlLmMgfCA0IC0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2ZzL2NpZnMvZmlsZS5jIGIvZnMvY2lmcy9maWxlLmMKaW5kZXggNjgzMWE5OTQ5YzQzLi5i
MzNkMmU3YjBmOTggMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvZmlsZS5jCisrKyBiL2ZzL2NpZnMvZmls
ZS5jCkBAIC00MDEwLDcgKzQwMTAsNiBAQCBzdGF0aWMgdm9pZAogY29sbGVjdF91bmNhY2hlZF9y
ZWFkX2RhdGEoc3RydWN0IGNpZnNfYWlvX2N0eCAqY3R4KQogewogCXN0cnVjdCBjaWZzX3JlYWRk
YXRhICpyZGF0YSwgKnRtcDsKLQlzdHJ1Y3QgaW92X2l0ZXIgKnRvID0gJmN0eC0+aXRlcjsKIAlz
dHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3NiOwogCWludCByYzsKIApAQCAtNDA3Niw5ICs0MDc1
LDYgQEAgY29sbGVjdF91bmNhY2hlZF9yZWFkX2RhdGEoc3RydWN0IGNpZnNfYWlvX2N0eCAqY3R4
KQogCQlrcmVmX3B1dCgmcmRhdGEtPnJlZmNvdW50LCBjaWZzX3JlYWRkYXRhX3JlbGVhc2UpOwog
CX0KIAotCWlmICghY3R4LT5kaXJlY3RfaW8pCi0JCWN0eC0+dG90YWxfbGVuID0gY3R4LT5sZW4g
LSBpb3ZfaXRlcl9jb3VudCh0byk7Ci0KIAkvKiBtYXNrIG5vZGF0YSBjYXNlICovCiAJaWYgKHJj
ID09IC1FTk9EQVRBKQogCQlyYyA9IDA7Ci0tIAoyLjM0LjEKCg==
--0000000000007f50d805f9a73dd3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-cifs-Reapply-lost-fix-from-commit-30b2b2196d6e.patch"
Content-Disposition: attachment; 
	filename="0003-cifs-Reapply-lost-fix-from-commit-30b2b2196d6e.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lgn2vyyh1>
X-Attachment-Id: f_lgn2vyyh1

RnJvbSAwMjNmYzE1MGEzOWZmZTY1NmRhM2U0NTlhZDgwMWViMWM3ZmRmYWQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBUdWUsIDE4IEFwciAyMDIzIDIzOjQ5OjEyICswMTAwClN1YmplY3Q6IFtQQVRDSCAzLzNd
IGNpZnM6IFJlYXBwbHkgbG9zdCBmaXggZnJvbSBjb21taXQgMzBiMmIyMTk2ZDZlCgpSZWFwcGx5
IHRoZSBmaXggZnJvbToKCiAgIDMwYjJiMjE5NmQ2ZSAoImNpZnM6IGRvIG5vdCBpbmNsdWRlIHBh
Z2UgZGF0YSB3aGVuIGNoZWNraW5nIHNpZ25hdHVyZSIpCgp0aGF0IGdvdCBsb3N0IGluIHRoZSBp
dGVyYXRvcmlzYXRpb24gb2YgdGhlIGNpZnMgZHJpdmVyLgoKRml4ZXM6IGQwODA4OWY2NDlhMCAo
ImNpZnM6IENoYW5nZSB0aGUgSS9PIHBhdGhzIHRvIHVzZSBhbiBpdGVyYXRvciByYXRoZXIgdGhh
biBhIHBhZ2UgbGlzdCIpCkFja2VkLWJ5OiBQYXVsbyBBbGNhbnRhcmEgKFNVU0UpIDxwY0BtYW5n
dWViaXQuY29tPgpSZXBvcnRlZC1ieTogUGF1bG8gQWxjYW50YXJhIDxwY0BtYW5ndWViaXQuY29t
PgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpjYzog
UGF1bG8gQWxjYW50YXJhIDxwY0BjanIubno+CmNjOiBTaHlhbSBQcmFzYWQgTiA8bnNwbWFuZ2Fs
b3JlQGdtYWlsLmNvbT4KY2M6IEJoYXJhdGggUyBNIDxiaGFyYXRoc21AbWljcm9zb2Z0LmNvbT4K
Y2M6IEVuem8gTWF0c3VtaXlhIDxlbWF0c3VtaXlhQHN1c2UuZGU+CmNjOiBsaW51eC1jaWZzQHZn
ZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jv
c29mdC5jb20+Ci0tLQogZnMvY2lmcy9zbWIycGR1LmMgfCAxMCArKysrKystLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Zz
L2NpZnMvc21iMnBkdS5jIGIvZnMvY2lmcy9zbWIycGR1LmMKaW5kZXggNDI0NTI0OWRiYmE4Li4z
NjZmMGMzYjc5OWIgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvc21iMnBkdS5jCisrKyBiL2ZzL2NpZnMv
c21iMnBkdS5jCkBAIC00MTgwLDEwICs0MTgwLDEyIEBAIHNtYjJfcmVhZHZfY2FsbGJhY2soc3Ry
dWN0IG1pZF9xX2VudHJ5ICptaWQpCiAJc3RydWN0IHNtYjJfaGRyICpzaGRyID0KIAkJCQkoc3Ry
dWN0IHNtYjJfaGRyICopcmRhdGEtPmlvdlswXS5pb3ZfYmFzZTsKIAlzdHJ1Y3QgY2lmc19jcmVk
aXRzIGNyZWRpdHMgPSB7IC52YWx1ZSA9IDAsIC5pbnN0YW5jZSA9IDAgfTsKLQlzdHJ1Y3Qgc21i
X3Jxc3QgcnFzdCA9IHsgLnJxX2lvdiA9ICZyZGF0YS0+aW92WzFdLAotCQkJCSAucnFfbnZlYyA9
IDEsCi0JCQkJIC5ycV9pdGVyID0gcmRhdGEtPml0ZXIsCi0JCQkJIC5ycV9pdGVyX3NpemUgPSBp
b3ZfaXRlcl9jb3VudCgmcmRhdGEtPml0ZXIpLCB9OworCXN0cnVjdCBzbWJfcnFzdCBycXN0ID0g
eyAucnFfaW92ID0gJnJkYXRhLT5pb3ZbMV0sIC5ycV9udmVjID0gMSB9OworCisJaWYgKHJkYXRh
LT5nb3RfYnl0ZXMpIHsKKwkJcnFzdC5ycV9pdGVyCSAgPSByZGF0YS0+aXRlcjsKKwkJcnFzdC5y
cV9pdGVyX3NpemUgPSBpb3ZfaXRlcl9jb3VudCgmcmRhdGEtPml0ZXIpOworCX07CiAKIAlXQVJO
X09OQ0UocmRhdGEtPnNlcnZlciAhPSBtaWQtPnNlcnZlciwKIAkJICAicmRhdGEgc2VydmVyICVw
ICE9IG1pZCBzZXJ2ZXIgJXAiLAotLSAKMi4zNC4xCgo=
--0000000000007f50d805f9a73dd3--
